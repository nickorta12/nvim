{ lib, pkgs, ... }:
{
  imports = [
    ./conform.nix
    ./extra.nix
    ./git.nix
    ./lsp.nix
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
    # Better comments
    comment.enable = true;
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
    # Edit files in a buffer
    oil.enable = true;
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
    # Better surrounding of characters
    nvim-surround = {
      enable = true;
      settings.keymaps = {
        insert = "<C-g>z";
        insert_line = "<C-g>Z";
        normal = "gz";
        normal_cur = "gzz";
        normal_line = "gZ";
        normal_cur_line = "gZZ";
        visual = "Z";
        visual_line = "gZ";
        delete = "dz";
        change = "cz";
        change_line = "cZ";
      };
    };

    # Better vim motions
    flash = {
      enable = true;
      settings = {
        modes.char.enabled = false;
      };
    };

    # Better undo handling
    undotree = {
      enable = true;
      settings = {
        SetFocusWhenToggle = 1;
        HighlightChangedText = 1;
        WindowLayout = 3;
      };
    };

    # Transparent background
    transparent = {
      enable = true;
      autoLoad = true;
    };

    web-devicons.enable = true;

    mini = {
      enable = true;
      modules = {
        ai = { };
      };
    };

    snacks = {
      enable = true;
      # Build on latest until nixpkgs catches up
      package = pkgs.vimUtils.buildVimPlugin {
        pname = "snacks.nvim";
        version = "2025-02-09";
        src = pkgs.fetchFromGitHub {
          owner = "folke";
          repo = "snacks.nvim";
          rev = "2f2f4c95afc280058f99ed9eb211a70a6a3e9edb";
          sha256 = "sha256-JsZ2WhED4PO8eD+2AKn2ceqcKB9+B3PE2N8DVtywyMs=";
        };
        meta.homepage = "https://github.com/folke/snacks.nvim/";
        meta.hydraPlatforms = [ ];
        nvimSkipModule = [
          # Requires setup call first
          "snacks.dashboard"
          "snacks.debug"
          "snacks.dim"
          "snacks.git"
          "snacks.indent"
          "snacks.input"
          "snacks.lazygit"
          "snacks.notifier"
          "snacks.scratch"
          "snacks.scroll"
          "snacks.terminal"
          "snacks.win"
          "snacks.words"
          "snacks.zen"
          "snacks.picker.core.list"
          "snacks.picker.config.highlights"
          "snacks.picker.actions"
          # Optional trouble integration
          "trouble.sources.profiler"
          # TODO: Plugin requires libsqlite available, create a test for it
          "snacks.picker.util.db"
        ];
      };
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
    };
  };
}
