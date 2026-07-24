{ lib, ... }:
{
  imports = [
    ./config.nix
    ./keys.nix
    ./plugins
  ];

  performance = {
    byteCompileLua = {
      enable = true;
      nvimRuntime = true;
      configs = true;
      plugins = false;
    };

    combinePlugins = {
      enable = false;
      standalonePlugins = [
        "nvim-treesitter"
        "conform.nvim"
      ];
    };
  };

  colorschemes = lib.mkDefault {
    tokyonight = {
      enable = true;
      settings.style = "night";
    };
  };

  files =
    let
      indent = num: {
        localOpts = {
          tabstop = num;
          softtabstop = num;
          shiftwidth = num;
        };
      };
    in
    {
      "ftplugin/lua.lua" = indent 2;
      "ftplugin/nix.lua" = indent 2;
      "ftplugin/yaml.lua" = indent 2;
      "ftplugin/markdown.lua" = {
        opts.textwidth = 100;
      };
      "ftplugin/alpha" = {
        localOpts.buflisted = false;
      };
    };

  extraFiles."lua/nickvim/open_url.lua".text = ''
    local M = {}

    local function url_at(line, column)
      local search_from = 1
      while true do
        local link_start, link_end, url =
          line:find("%b[]%(%s*<?([%a][%w+.-]*://[^%s>%)]+)>?[^%)]*%)", search_from)
        if not link_start then
          break
        end
        if column >= link_start and column <= link_end then
          return url
        end
        search_from = link_end + 1
      end

      search_from = 1
      while true do
        local url_start, url_end = line:find("[%a][%w+.-]*://[^%s<>]+", search_from)
        if not url_start then
          return nil
        end

        local url = line:sub(url_start, url_end):gsub("[,.;:!?%)%]%}]+$", "")
        url_end = url_start + #url - 1
        if column >= url_start and column <= url_end then
          return url
        end
        search_from = math.max(url_end + 1, url_start + 1)
      end
    end

    local function open_external(url)
      local process, error_message = vim.ui.open(url)
      if not process then
        vim.notify(error_message or ("Could not open " .. url), vim.log.levels.ERROR)
      end
    end

    local function open_file(uri)
      local file_uri, fragment = uri:match("^([^#]+)#?(.*)$")
      local path = vim.uri_to_fname(file_uri)
      local line, column = fragment:match("^L(%d+),?(%d*)$")

      local current_win = vim.api.nvim_get_current_win()
      local win_config = vim.api.nvim_win_get_config(current_win)
      if win_config.relative ~= "" and win_config.win and vim.api.nvim_win_is_valid(win_config.win) then
        vim.api.nvim_set_current_win(win_config.win)
      end

      vim.cmd.normal({ args = { "m'" }, bang = true })
      local ok, error_message = pcall(
        vim.api.nvim_cmd,
        { cmd = "edit", args = { path }, mods = { hide = true } },
        {}
      )
      if not ok then
        vim.notify(error_message, vim.log.levels.ERROR)
        return
      end

      if line then
        vim.api.nvim_win_set_cursor(0, { tonumber(line), math.max(tonumber(column) or 1, 1) - 1 })
        vim.cmd.normal({ args = { "zz" }, bang = true })
      end
    end

    local function open(url)
      if vim.startswith(url, "file://") then
        open_file(url)
      else
        open_external(url)
      end
    end

    function M.open_under_cursor(fallback)
      local cursor = vim.api.nvim_win_get_cursor(0)
      local url = url_at(vim.api.nvim_get_current_line(), cursor[2] + 1)
      if url then
        open(url)
        return
      end

      if fallback ~= false then
        vim.cmd.normal({ args = { "gx" }, bang = true })
      end
    end

    function M.goto_link(direction)
      local links = {}
      for line_number, line in ipairs(vim.api.nvim_buf_get_lines(0, 0, -1, false)) do
        local search_from = 1
        while true do
          local link_start, link_end =
            line:find("%b[]%(%s*<?[%a][%w+.-]*://[^%s>%)]+>?[^%)]*%)", search_from)
          if not link_start then
            break
          end
          table.insert(links, { line_number, link_start })
          search_from = link_end + 1
        end
      end

      if #links == 0 then
        return
      end

      local cursor = vim.api.nvim_win_get_cursor(0)
      if direction > 0 then
        for _, position in ipairs(links) do
          if position[1] > cursor[1] or (position[1] == cursor[1] and position[2] > cursor[2]) then
            vim.api.nvim_win_set_cursor(0, position)
            return
          end
        end
        vim.api.nvim_win_set_cursor(0, links[1])
      else
        for index = #links, 1, -1 do
          local position = links[index]
          if position[1] < cursor[1] or (position[1] == cursor[1] and position[2] < cursor[2]) then
            vim.api.nvim_win_set_cursor(0, position)
            return
          end
        end
        vim.api.nvim_win_set_cursor(0, links[#links])
      end
    end

    function M.open_under_mouse()
      local mouse = vim.fn.getmousepos()
      if mouse.winid == 0 or mouse.line == 0 or mouse.column == 0 then
        return
      end

      vim.api.nvim_set_current_win(mouse.winid)
      vim.api.nvim_win_set_cursor(mouse.winid, { mouse.line, mouse.column - 1 })

      local url = url_at(vim.api.nvim_get_current_line(), mouse.column)
      if url then
        open(url)
      end
    end

    return M
  '';

  autoCmd = [
    # {
    #   event = [ "FileType" ];
    #   pattern = "TelescopePrompt";
    #   command = "inoremap <buffer><silent> <ESC> <ESC>:close!<CR>";
    # }
    {
      event = [ "BufEnter" ];
      pattern = "*.txt";
      callback = lib.nixvim.mkRaw ''
        function()
          if vim.bo.filetype == 'help' and vim.b.already_opened == nil then
            vim.b.already_opened = true
            vim.cmd('wincmd T')
          end
        end
      '';
    }
    {
      event = [ "FileType" ];
      pattern = "markdown";
      callback = lib.nixvim.mkRaw ''
        function(event)
          vim.keymap.set("n", "gx", require("nickvim.open_url").open_under_cursor, {
            buffer = event.buf,
            desc = "Open URL under cursor",
          })
        end
      '';
    }
    {
      event = [ "WinEnter" ];
      pattern = "*";
      callback = lib.nixvim.mkRaw ''
        function(event)
          local win = vim.api.nvim_get_current_win()
          if
            vim.bo[event.buf].filetype == "markdown"
            and vim.api.nvim_win_get_config(win).relative ~= ""
          then
            vim.api.nvim_set_option_value("concealcursor", "n", { win = win })
            local open_url = require("nickvim.open_url")
            local options = { buffer = event.buf, silent = true }
            vim.keymap.set("n", "<Tab>", function()
              open_url.goto_link(1)
            end, options)
            vim.keymap.set("n", "<S-Tab>", function()
              open_url.goto_link(-1)
            end, options)
            vim.keymap.set("n", "<CR>", function()
              open_url.open_under_cursor(false)
            end, options)
          end
        end
      '';
    }
  ];
  keymaps = [
    {
      mode = "n";
      key = "<C-LeftMouse>";
      action = lib.nixvim.mkRaw ''require("nickvim.open_url").open_under_mouse'';
      options.desc = "Open URL under mouse";
    }
  ];
}
