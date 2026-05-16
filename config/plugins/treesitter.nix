{ pkgs, ... }:
{
  extraPackages = [ pkgs.tree-sitter ];
  extraConfigLua = ''
    vim.treesitter.language.add("jsonc", {
      path = "${pkgs.vimPlugins.nvim-treesitter.builtGrammars.json}/parser",
      symbol_name = "json",
    })
    vim.treesitter.language.register("json", "jsonc")
  '';
  plugins = {
    treesitter = {
      enable = true;
      nixvimInjections = true;
      folding.enable = false;
      nixGrammars = true;
      grammarPackages = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
        bash
        c
        cpp
        fish
        java
        javascript
        json
        json5
        just
        kdl
        lua
        markdown
        nix
        python
        regex
        rust
        toml
        tsx
        typescript
        xml
        yaml
      ];
      settings = {
        highlight.enable = true;
        incremental_selection.enable = true;
        indent.enable = true;
      };
    };
  };
}
