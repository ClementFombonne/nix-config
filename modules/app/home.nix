{ inputs, pkgs, config, osConfig, ... }:

{
    imports = [
        ./firefox/home.nix
        ./ghostty/home.nix
    ];
}
