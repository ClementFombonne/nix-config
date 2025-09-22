{ inputs, pkgs, config, osConfig, ... }:

{
    imports = [
        ./dunst
	    ./eww
        ./hyprland
	    ./sddm
        ./gdm
	    ./waybar
        ./rofi
        ./nmgui
    ];
}
