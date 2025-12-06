{
  inputs,
  pkgs,
  lib,
  config,
  osConfig,
  mkSymlink,
  ...
}:

with lib;
let
  cfg = osConfig.modules.hyprland;
  modulePath = "modules/gui/hyprland";
in
{
  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      hyprpaper
      hyprlock
      hypridle
      hyprshot
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

    xdg.configFile."hypr/hyprland.conf".source = mkSymlink "${modulePath}/hyprland.conf";
    xdg.configFile."hypr/conf/keybinds.conf".source = mkSymlink "${modulePath}/conf/keybinds.conf";
    xdg.configFile."hypr/hyprlock.conf".source = mkSymlink "${modulePath}/hyprlock.conf";
    xdg.configFile."hypr/hyprpaper.conf".source = mkSymlink "${modulePath}/hyprpaper.conf";
    xdg.configFile."hypr/hypridle.conf".source = mkSymlink "${modulePath}/hypridle.conf";
    xdg.configFile."electron-flags.conf".source = mkSymlink "${modulePath}/electron-flags.conf";
  };
}
