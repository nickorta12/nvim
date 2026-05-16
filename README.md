# Nick's Custom nixvim Config

Custom [nixvim](https://github.com/nix-community/nixvim) configuration for myself

## Important Caveats

I'm using the latest binary version of `pyrefly` in this config instead of a nix built one to save
on compilation speed. On NixOS you'll need to have `nix-ld` enabled and some common linux libs
enabled for it to work. Should work fine on nix on other distros or MacOS.
