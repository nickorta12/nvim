{
  keymap,
  ...
}:
let
  inherit (keymap) nlua;
in
{
  plugins = {
    lsp = {
      enable = true;
      servers = {
        # nil_ls = {
        #   enable = true;
        #   settings.nix = {
        #     maxMemoryMB = lib.mkDefault 4096;
        #     flake.autoEvalInputs = true;
        #   };
        #   onAttach.function = "client.server_capabilities.semanticTokensProvider = nil";
        # };
        nixd = {
          enable = true;
          settings.formatting.command = [ "nixfmt" ];
          onAttach.function = "client.server_capabilities.semanticTokensProvider = nil";
        };
        basedpyright = {
          enable = true;
          # package = basedpyright;
          settings.basedpyright = {
            analysis.typeCheckingMode = "basic";
            inlayHints.callArgumentNames = true;
          };
        };
        ruff.enable = true;
        jsonls.enable = true;
        lua_ls.enable = true;
      };
      capabilities = "capabilities = require('blink.cmp').get_lsp_capabilities(capabilities)";
      keymaps.extra = [
        (nlua "K" "vim.lsp.buf.hover()" "Hover")
        (nlua "gi" "vim.lsp.buf.implementation()" "Go to implementation")
        (nlua "go" "vim.lsp.buf.type_definition()" "Go to type definition")
        (nlua "gS" "vim.lsp.buf.signature_help()" "Show signature help")
        # -- LSP
        (nlua "gd" "Snacks.picker.lsp_definitions()" "Goto Definition")
        (nlua "gD" "Snacks.picker.lsp_declarations()" "Goto Declaration")
        (nlua "grr" "Snacks.picker.lsp_references()" "Goto References")
        (nlua "gri" "Snacks.picker.lsp_implementations()" "Goto Implementation")
        (nlua "grt" "Snacks.picker.lsp_type_definitions()" "Goto Type Definition")
        (nlua "<leader>ss" "Snacks.picker.lsp_symbols()" "LSP Symbols")
        (nlua "<leader>sS" "Snacks.picker.lsp_workspace_symbols()" "LSP Workspace Symbols")
        (nlua "<F2>" "vim.lsp.buf.rename()" "Rename")
        (nlua "<F4>" "vim.lsp.buf.code_action()" "Code action")

        (nlua "<leader>vd" "vim.lsp.buf.definition()" "Go to definition")
        (nlua "<leader>vD" "vim.lsp.buf.declaration()" "Go to declaration")
        (nlua "<leader>vi" "vim.lsp.buf.implementation()" "Go to implementation")
        (nlua "<leader>vo" "vim.lsp.buf.type_definition()" "Go to type definition")
        (nlua "<leader>vr" "vim.lsp.buf.references()" "Go to references")
        (nlua "<leader>vs" "vim.lsp.buf.signature_help()" "Show signature help")
        (nlua "<leader>vc" "vim.lsp.buf.code_action()" "Code action")
      ];
    };

    lsp-status.enable = true;

    rustaceanvim = {
      enable = true;
      settings.server.default_settings.rust-analyzer = {
        files.excludeDirs = [
          ".git"
          ".cargo"
          "target"
          ".direnv"
        ];

      };
    };
    lsp-signature = {
      enable = true;
      settings = {
        floating_window = false;
        hint_prefix = "";
        toggle_key = "<C-s>";
      };
    };

    luasnip.enable = true;
    blink-cmp = {
      enable = true;
      settings = {
        cmdline = {
          keymap = {
            "<Tab>" = [
              "show"
              "accept"
            ];
          };
          completion.menu = {
            auto_show = true;
            draw.columns = {
              __unkeyed-1 = {
                __unkeyed-1 = "kind_icon";
              };
              __unkeyed-2 = {
                __unkeyed-1 = "label";
              };
            };
          };
        };
        keymap = {
          preset = "super-tab";
          "<C-y>" = [ "select_and_accept" ];
          "<CR>" = [
            "accept"
            "fallback"
          ];
        };
        completion.trigger.show_in_snippet = false;
        signature.enabled = true;
      };
    };

    trouble.enable = true;
    nvim-lightbulb.enable = true;

    neoconf = {
      enable = true;
    };
  };
  dependencies.rust-analyzer.enable = false;
}
