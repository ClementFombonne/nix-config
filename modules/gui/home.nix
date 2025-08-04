{ inputs, pkgs, config, osConfig, ... }:

{
    imports = [
        ./dunst/home.nix
	./eww/home.nix
        ./hyprland/home.nix
	./waybar/home.nix
        ./wofi/home.nix
    ];
}
