{ pkgs, ... }:
{
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
        java
        javascript
        json
        jsonc
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

    treesitter-refactor.enable = true;
  };
}
