{ inputs, pkgs, lib, config, osConfig, ... }:

with lib;
let cfg = osConfig.modules.hyprland;

in {
    config = mkIf cfg.enable {
        home.packages = with pkgs; [
	    hyprpaper hyprlock hypridle hyprshot
	    magnetic-catppuccin-gtk
	    bibata-cursors
	    papirus-icon-theme
	];
        
        
	home.pointerCursor = {
            gtk.enable = true;
            x11.enable = true;
            package = pkgs.bibata-cursors;
            name = "Bibata-Modern-Ice";
            size = 25;
        };
        gtk = {
            enable = true;
	    font.name = "DejaVu Sans";
            font.size = 12;
            theme = {
                name = "Catppuccin-Frappe-Standard-Blue-Dark";
                package = pkgs.magnetic-catppuccin-gtk;
	    };
            iconTheme = {
                name = "Papirus-Dark";
                package = pkgs.papirus-icon-theme;
            };
            cursorTheme = {
                name = "Bibata-Modern-Ice";
                package = pkgs.bibata-cursors;
            };
        };

        home.file.".config/hypr/hyprland.conf".source = ./hyprland.conf;
        home.file.".config/hypr/hyprpaper.conf".source = ./hyprpaper.conf;
        home.file.".config/hypr/hypridle.conf".source = ./hypridle.conf;
    };
}
