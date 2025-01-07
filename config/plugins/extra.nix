# Packages not in nixvim or even nixpkgs
{pkgs, ...}: let
  key-analyzer = pkgs.vimUtils.buildVimPlugin {
    name = "key-analyzer";
    src = pkgs.fetchFromGitHub {
      owner = "meznaric";
      repo = "key-analyzer.nvim";
      rev = "15d2663dd5014ef2814f2df1edc04494f2c1ee56";
      hash = "sha256-ZR6QfaPL3hBNdPFUoS6Q9NKwnYQovUEf5eAcw+uiFSM=";
    };
    patches = [./no-promo.patch];
  };
in {
  extraPlugins = [key-analyzer];
  extraConfigLua = ''
    require("key-analyzer").setup()
  '';
}
