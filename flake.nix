{
  description = "A nixvim configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        home-manager.follows = "";
        devshell.follows = "";
        flake-compat.follows = "";
        git-hooks.follows = "";
        nix-darwin.follows = "";
        treefmt-nix.follows = "";
        nuschtosSearch.follows = "";
      };
    };
  };

  outputs =
    {
      nixvim,
      flake-parts,
      ...
    }@inputs:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [
        "x86_64-linux"
        "aarch64-linux"
        "x86_64-darwin"
        "aarch64-darwin"
      ];

      perSystem =
        {
          pkgs,
          system,
          ...
        }:
        let
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
          nvim = nixvim'.makeNixvimWithModule nixvimModule;
          bnvim = nixvim'.makeNixvimWithModule {
            inherit pkgs;
            module =
              { lib, ... }:
              {
                imports = [
                  ./config/config.nix
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
        in
        {
          checks = {
            # Run `nix flake check .` to verify that your config is not broken
            default = nixvimLib.check.mkTestDerivationFromNixvimModule nixvimModule;
          };

          packages = {
            # Lets you run `nix run .` to start nixvim
            default = nvim;
            inherit bnvim;
          };

          formatter = pkgs.nixfmt-rfc-style;
        };
    };
}
