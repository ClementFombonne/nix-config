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
      hyprshot
    ];

    xdg.configFile."hypr/hyprland.lua".source = mkSymlink "${modulePath}/hyprland.lua";
    xdg.configFile."hypr/conf/keybinds.lua".source = mkSymlink "${modulePath}/conf/keybinds.lua";
    xdg.configFile."electron-flags.conf".source = mkSymlink "${modulePath}/electron-flags.conf";
  };
}
