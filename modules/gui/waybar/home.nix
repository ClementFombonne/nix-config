{ inputs, pkgs, lib, config, osConfig, ... }:

with lib;
let cfg = osConfig.modules.waybar;

in {
    config = mkIf cfg.enable {
        programs.waybar.enable = true;

        # waybar config  
        xdg.configFile."waybar/config.jsonc".source = ./config.jsonc;
        xdg.configFile."waybar/style.css".source = ./style.css;
        xdg.configFile."waybar/color.css".source = ./color.css;

        # nwg-bar
        xdg.configFile."nwg-bar/bar.json".source = ./nwg-bar/bar.json;
        xdg.configFile."nwg-bar/style.css".source = ./nwg-bar/style.css;
        xdg.configFile."nwg-bar/images/system-lock-screen.svg".source = ./nwg-bar/images/system-lock-screen.svg;
        xdg.configFile."nwg-bar/images/system-reboot.svg".source = ./nwg-bar/images/system-reboot.svg;
        xdg.configFile."nwg-bar/images/system-log-out.svg".source = ./nwg-bar/images/system-log-out.svg;
        xdg.configFile."nwg-bar/images/system-shutdown.svg".source = ./nwg-bar/images/system-shutdown.svg;
    };
}
