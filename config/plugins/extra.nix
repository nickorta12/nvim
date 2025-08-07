# Packages not in nixvim or even nixpkgs
{ pkgs, ... }:
let
  key-analyzer = pkgs.vimUtils.buildVimPlugin {
    name = "key-analyzer";
    src = pkgs.fetchFromGitHub {
      owner = "meznaric";
      repo = "key-analyzer.nvim";
      rev = "4e4bef34498e821bcbd5203f44db8b67e4f10e04";
      hash = "sha256-os2Z+Lyu22EcSq2zaelV26ZRGulNEmF5T1iBn0wTliA=";
    };
  };
in
{
  extraPlugins = [ key-analyzer ];
  extraConfigLua = ''
    require("key-analyzer").setup({
      promotion = false
    })
  '';
}
