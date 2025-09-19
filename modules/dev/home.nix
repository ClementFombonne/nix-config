{ inputs, pkgs, config, ... }:

{
    imports = [
        ./python-uv/home.nix
        ./gcc/home.nix
    ];
}
