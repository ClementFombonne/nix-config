{ inputs, pkgs, config, osConfig, ... }:

{
    imports = [
        ./firefox/home.nix
        ./ghostty/home.nix
        ./zen-browser/home.nix
        ./discord/home.nix
    ];
}
