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
  cfg = osConfig.modules.waybar;
  modulePath = "modules/gui/waybar";
in
{
  config = mkIf cfg.enable {
    programs.waybar.enable = true;

    # waybar config
    xdg.configFile."waybar/config.jsonc".source = mkSymlink "${modulePath}/config.jsonc";
    xdg.configFile."waybar/style.css".source = mkSymlink "${modulePath}/style.css";
    xdg.configFile."waybar/color.css".source = mkSymlink "${modulePath}/color.css";

    # nwg-bar
    xdg.configFile."nwg-bar/bar.json".source = mkSymlink "${modulePath}/nwg-bar/bar.json";
    xdg.configFile."nwg-bar/style.css".source = mkSymlink "${modulePath}/nwg-bar/style.css";
    xdg.configFile."nwg-bar/images/system-lock-screen.svg".source = mkSymlink "${modulePath}/nwg-bar/images/system-lock-screen.svg";
    xdg.configFile."nwg-bar/images/system-reboot.svg".source = mkSymlink "${modulePath}/nwg-bar/images/system-reboot.svg";
    xdg.configFile."nwg-bar/images/system-log-out.svg".source = mkSymlink "${modulePath}/nwg-bar/images/system-log-out.svg";
    xdg.configFile."nwg-bar/images/system-shutdown.svg".source = mkSymlink "${modulePath}/nwg-bar/images/system-shutdown.svg";
  };
}
