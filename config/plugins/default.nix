{
  imports = [
    ./conform.nix
    ./extra.nix
    ./git.nix
    ./lsp.nix
    ./telescope.nix
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
        normal = "yz";
        normal_cur = "yzz";
        normal_line = "yZ";
        normal_cur_line = "yZZ";
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

    snacks = {
      enable = true;
      settings = {
        input.enabled = true;
        lazygit.enabled = true;
        # profiler.enabled = true;
        terminal.enabled = true;
      };
    };
  };
}
