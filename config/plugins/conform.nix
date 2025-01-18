{ lib, ... }:
{
  plugins.conform-nvim = {
    enable = true;
    settings = {
      formatters_by_ft = {
        nix = [ "nixfmt" ];
        python = [
          "ruff_format"
          "ruff_fix"
        ];
        rust = [ "rustfmt" ];
        "_" = [
          "squeeze_blanks"
          "trim_whitespace"
          "trim_newlines"
        ];
      };
      format_on_save = lib.nixvim.mkRaw ''
        function(bufnr)
          -- Disable with a global or buffer-local variable
          if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
            return
          end
          return { timeout_ms = 500, lsp_format = "fallback" }
        end
      '';
      # format_on_save = {
      #   lsp_format = "fallback";
      #   timeout_ms = 500;
      # };
      # format_after_save = {
      #   lsp_format = "fallback";
      # };
    };
  };

  userCommands = {
    FormatDisable = {
      desc = "Disable autoformat-on-save";
      bang = true;
      command = lib.nixvim.mkRaw ''
        function(args)
          if args.bang then
            -- FormatDisable! will disable formatting just for this buffer
            vim.b.disable_autoformat = true
          else
            vim.g.disable_autoformat = true
          end
        end
      '';
    };
    FormatEnable = {
      desc = "Re-enable autoformat-on-save";
      command = lib.nixvim.mkRaw ''
        function(args)
          vim.b.disable_autoformat = false
          vim.g.disable_autoformat = false
        end
      '';
    };
  };
}
