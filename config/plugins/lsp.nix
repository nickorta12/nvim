{
  keymap,
  lib,
  ...
}:
let
  inherit (keymap) nlua;
  inherit (lib.nixvim.lua) toLuaObject;
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
      keymaps.extra =
        let
          rightbar = toLuaObject {
            layout = {
              preset = "right";
              preview = false;
            };
            jump.close = false;
            auto_close = false;
            focus = "list";
          };
        in
        [
          (nlua "K" /* lua */ "vim.lsp.buf.hover()" "Hover")
          (nlua "gS" /* lua */ "vim.lsp.buf.signature_help()" "Show signature help")

          (nlua "gi" /* lua */ "Snacks.picker.lsp_implementations()" "Goto Implementation")
          (nlua "go" /* lua */ "Snacks.picker.lsp_type_definitions()" "Goto Type Definition")
          (nlua "gd" /* lua */ "Snacks.picker.lsp_definitions()" "Goto Definition")
          (nlua "gD" /* lua */ "Snacks.picker.lsp_declarations()" "Goto Declaration")
          (nlua "grr" /* lua */ "Snacks.picker.lsp_references(${rightbar})" "Goto References")
          (nlua "gri" /* lua */ "Snacks.picker.lsp_implementations()" "Goto Implementation")
          (nlua "grt" /* lua */ "Snacks.picker.lsp_type_definitions()" "Goto Type Definition")
          (nlua "<leader>ss" /* lua */ "Snacks.picker.lsp_symbols(${rightbar})" "LSP Symbols")
          (nlua "<leader>sS" /* lua */ "Snacks.picker.lsp_workspace_symbols(${rightbar})" "LSP Workspace Symbols")
          (nlua "<F2>" /* lua */ "vim.lsp.buf.rename()" "Rename")
          (nlua "<F4>" /* lua */ "vim.lsp.buf.code_action()" "Code action")

          (nlua "<leader>vd" /* lua */ "vim.lsp.buf.definition()" "Go to definition")
          (nlua "<leader>vD" /* lua */ "vim.lsp.buf.declaration()" "Go to declaration")
          (nlua "<leader>vi" /* lua */ "vim.lsp.buf.implementation()" "Go to implementation")
          (nlua "<leader>vo" /* lua */ "vim.lsp.buf.type_definition()" "Go to type definition")
          (nlua "<leader>vr" /* lua */ "vim.lsp.buf.references()" "Go to references")
          (nlua "<leader>vs" /* lua */ "vim.lsp.buf.signature_help()" "Show signature help")
          (nlua "<leader>vc" /* lua */ "vim.lsp.buf.code_action()" "Code action")
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
