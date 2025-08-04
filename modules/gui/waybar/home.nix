{ inputs, pkgs, lib, config, osConfig, ... }:

with lib;
let cfg = osConfig.modules.waybar;

in {
    config = mkIf cfg.enable {
        programs.waybar.enable = true;

        home.file.".config/waybar/config.jsonc".source = ./config.jsonc;
        home.file.".config/waybar/style.css".source = ./style.css;
        home.file.".config/waybar/frappe.css".source = ./frappe.css;
    };
}
