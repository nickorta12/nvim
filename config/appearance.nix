{ lib, pkgs, ... }:
{
  extraPlugins = [ pkgs.vimPlugins.modus-themes-nvim ];

  extraConfigLua = lib.mkAfter ''
    -- Neovim discovers the terminal background via OSC 11 and receives
    -- updates when Ghostty follows the system appearance.
    local function apply_appearance()
      local name = vim.o.background == "light"
        and "modus" or "tokyonight-night"
      if vim.g.colors_name ~= name then
        vim.cmd.colorscheme(name)
      end
    end

    vim.api.nvim_create_autocmd("OptionSet", {
      group = vim.api.nvim_create_augroup("SystemAppearance", { clear = true }),
      pattern = "background",
      callback = function()
        vim.schedule(apply_appearance)
      end,
    })
    vim.api.nvim_create_autocmd("VimEnter", {
      group = "SystemAppearance",
      callback = apply_appearance,
    })
    apply_appearance()
  '';
}
