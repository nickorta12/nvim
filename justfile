build:
    nom build . -- --accept-flake-config

update:
    nix flake update --accept-flake-config --commit-lock-file

push:
    git push origin

format:
    nix fmt --accept-flake-config
