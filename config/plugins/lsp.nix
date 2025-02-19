{
  keymap,
  # pkgs,
  ...
}:
let
  nmap = keymap.mkKeyLua "n";
in
# Basedpyright caught up
# basedpyright = pkgs.callPackage ./basedpyright.nix { };
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
        jsonls.enable = true;
        lua_ls.enable = true;
      };
      capabilities = "capabilities = require('blink.cmp').get_lsp_capabilities(capabilities)";
      keymaps.extra = [
        (nmap "K" "vim.lsp.buf.hover()" "Hover")
        (nmap "gd" "vim.lsp.buf.definition()" "Go to definition")
        (nmap "gD" "vim.lsp.buf.declaration()" "Go to declaration")
        (nmap "gi" "vim.lsp.buf.implementation()" "Go to implementation")
        (nmap "go" "vim.lsp.buf.type_definition()" "Go to type definition")
        (nmap "gr" "vim.lsp.buf.references()" "Go to references")
        (nmap "gS" "vim.lsp.buf.signature_help()" "Show signature help")
        (nmap "<F2>" "vim.lsp.buf.rename()" "Rename")
        (nmap "<F4>" "vim.lsp.buf.code_action()" "Code action")

        (nmap "<leader>vd" "vim.lsp.buf.definition()" "Go to definition")
        (nmap "<leader>vD" "vim.lsp.buf.declaration()" "Go to declaration")
        (nmap "<leader>vi" "vim.lsp.buf.implementation()" "Go to implementation")
        (nmap "<leader>vo" "vim.lsp.buf.type_definition()" "Go to type definition")
        (nmap "<leader>vr" "vim.lsp.buf.references()" "Go to references")
        (nmap "<leader>vs" "vim.lsp.buf.signature_help()" "Show signature help")
        (nmap "<leader>vc" "vim.lsp.buf.code_action()" "Code action")
      ];
    };

    lspkind.enable = true;
    lsp-status.enable = true;

    rustaceanvim.enable = true;
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
        keymap = {
          preset = "super-tab";
          "<C-y>" = [ "select_and_accept" ];
          "<CR>" = [
            "accept"
            "fallback"
          ];
          cmdline = {
            preset = "super-tab";
          };
        };
        #   appearance.use_nvim_cmp_as_default = true;
        signature.enabled = true;
      };
    };

    trouble.enable = true;
    nvim-lightbulb.enable = true;

    neoconf = {
      enable = true;
    };
  };
}
