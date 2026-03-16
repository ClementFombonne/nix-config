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
      hyprshot
    ];

    xdg.configFile."hypr/hyprland.conf".source = mkSymlink "${modulePath}/hyprland.conf";
    xdg.configFile."hypr/conf/keybinds.conf".source = mkSymlink "${modulePath}/conf/keybinds.conf";
    xdg.configFile."hypr/hyprpaper.conf".source = mkSymlink "${modulePath}/hyprpaper.conf";
    xdg.configFile."electron-flags.conf".source = mkSymlink "${modulePath}/electron-flags.conf";
  };
}
