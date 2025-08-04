{ inputs, pkgs, config, osConfig, ... }:

{
    imports = [
        ./dunst
	./eww
        ./hyprland
	./sddm
	./waybar
        ./wofi
    ];
}
