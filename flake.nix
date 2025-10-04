{
  description = "A nixvim configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        nuschtosSearch.follows = "";
      };
    };
  };

  outputs =
    {
      nixvim,
      nixpkgs,
      self,
      ...
    }:
    let
      supportedSystems = [
        "x86_64-linux"
        "aarch64-linux"
        "aarch64-darwin"
        "x86_64-darwin"
      ];

      forEachSupportedSystem =
        f:
        nixpkgs.lib.genAttrs supportedSystems (
          system:
          let

            pkgs = import nixpkgs {
              inherit system;
              config = {
                allowUnfree = true;
              };
            };
            nixvimLib = nixvim.lib.${system};
            nixvim' = nixvim.legacyPackages.${system};
            nlib = import ./lib.nix pkgs.lib;
            nixvimModule = {
              inherit pkgs;
              module = import ./config; # import the module directly
              # You can use `extraSpecialArgs` to pass additional arguments to your module files
              extraSpecialArgs = {
                inherit (nlib) keymap;
              };
            };
          in
          f {
            inherit
              system
              pkgs
              nixvimLib
              nixvim'
              nixvimModule
              ;
          }
        );
    in
    {
      packages = forEachSupportedSystem (
        {
          system,
          pkgs,
          nixvim',
          nixvimModule,
          ...
        }:
        {
          nvim = nixvim'.makeNixvimWithModule nixvimModule;
          bnvim = nixvim'.makeNixvimWithModule {
            inherit pkgs;
            module =
              { lib, ... }:
              {
                imports = [
                  ./config/config.nix
                  ./config/plugins/minimal.nix
                  ./config/plugins/treesitter.nix
                ];
                colorschemes = lib.mkDefault {
                  tokyonight = {
                    enable = true;
                    settings.style = "night";
                  };
                };
                performance.byteCompileLua = {
                  enable = true;
                  nvimRuntime = true;
                  configs = true;
                  plugins = false;
                };
                plugins.transparent = {
                  enable = true;
                  autoLoad = true;
                };
                opts.wrap = lib.mkForce true;
              };
          };
          default = self.packages.${system}.nvim;
        }
      );
      checks = forEachSupportedSystem (
        {
          nixvimLib,
          nixvimModule,
          ...
        }:
        {
          default = nixvimLib.check.mkTestDerivationFromNixvimModule nixvimModule;
        }
      );
    };
}
