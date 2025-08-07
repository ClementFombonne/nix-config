{ inputs, pkgs, config, ... }:

{
    imports = [
        ./firefox
        ./ghostty
        ./zen-browser
    ];
}
