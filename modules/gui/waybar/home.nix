{ inputs, pkgs, lib, config, osConfig, ... }:

with lib;
let cfg = osConfig.modules.waybar;

in {
    config = mkIf cfg.enable {
        programs.waybar.enable = true;

        # waybar config  
        home.file.".config/waybar/config.jsonc".source = ./config.jsonc;
        home.file.".config/waybar/style.css".source = ./style.css;
        home.file.".config/waybar/frappe.css".source = ./frappe.css;

        # nwg-bar
        home.file.".config/nwg-bar/bar.json".source = ./nwg-bar/bar.json;
        home.file.".config/nwg-bar/style.css".source = ./nwg-bar/style.css;
        home.file.".config/nwg-bar/images/system-lock-screen.svg".source = ./nwg-bar/system-lock-screen.svg;
        home.file.".config/nwg-bar/images/system-reboot.svg".source = ./nwg-bar/system-reboot.svg;
        home.file.".config/nwg-bar/images/system-log-out.svg".source = ./nwg-bar/system-log-out.svg;
        home.file.".config/nwg-bar/images/system-shutdown.svg".source = ./nwg-bar/system-shutdown.svg;
    };
}
