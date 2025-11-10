{ lib, pkgs, ... }:
{
  imports = [
    ./conform.nix
    ./git.nix
    ./lsp.nix
    ./minimal.nix
    ./multicursor.nix
    ./treesitter.nix
  ];

  # extraConfigLuaPre = ''
  #   if vim.env.PROF then
  #       require("snacks.profiler").startup({
  #         startup = {
  #           event = "VimEnter", -- stop profiler on this event. Defaults to `VimEnter`
  #           -- event = "UIEnter",
  #           -- event = "VeryLazy",
  #         },
  #       })
  #     end
  # '';

  plugins = {
    # Reopens files at last edit position
    lastplace.enable = true;
    # Auto make pairs
    nvim-autopairs.enable = true;
    # Better buffer delete
    vim-bbye.enable = true;
    # Nicer tab line
    bufferline = {
      enable = true;
      settings.options = {
        mode = "tabs";
        diagnostics = "nvim_lsp";
        separator_style = "slant";
        show_duplicate_prefix = false;
        custom_filter = lib.nixvim.mkRaw ''
          function(buf_number, buf_numbers)
            return vim.bo[buf_number].filetype ~= "snacks_picker_input"
          end
        '';
      };
    };
    # Like harpoon to save files
    arrow = {
      enable = true;
      settings = {
        show_icons = true;
        leader_key = ";";
        buffer_leader_key = "m";
      };
    };
    # Better status line
    lualine.enable = true;
    # Indent guides
    indent-blankline.enable = true;
    # Better file finder
    yazi = {
      enable = true;
      settings = {
        enable_mouse_support = true;
      };
    };
    # Sidebar
    # neo-tree = {
    #   enable = true;
    #   closeIfLastWindow = false;
    #   filesystem = {
    #     useLibuvFileWatcher = true;
    #     followCurrentFile.enabled = true;
    #   };
    # };

    # Better vim motions
    flash = {
      enable = true;
      settings = {
        modes.char.enabled = false;
      };
    };

    # Transparent background
    transparent = {
      enable = true;
      autoLoad = true;
    };

    web-devicons.enable = true;

    snacks = {
      enable = true;
      settings = {
        input.enabled = true;
        lazygit.enabled = true;
        notifier.enabled = true;
        # profiler.enabled = true;
        terminal.enabled = true;
        picker = {
          enabled = true;
          db.sqlite3_path = "${pkgs.sqlite.out}/lib/libsqlite3${pkgs.stdenv.hostPlatform.extensions.sharedLibrary}";
        };
        explorer.enabled = true;
      };
      luaConfig.post = ''
        Snacks.toggle.option("wrap", {name = "Wrap"}):map("<leader>uw")
        Snacks.toggle.diagnostics():map("<leader>ud")
        Snacks.toggle.inlay_hints():map("<leader>uh")
        Snacks.layout.no_preview = {
          
        }
      '';
    };
  };

  dependencies = {
    git.enable = false;
    yazi.package = pkgs.yazi.override { optionalDeps = [ ]; };
  };
}
