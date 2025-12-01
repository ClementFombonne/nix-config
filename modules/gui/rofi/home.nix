{ pkgs, lib, config, osConfig, ... }:

with lib;
let cfg = osConfig.modules.rofi;

in {
    config = mkIf cfg.enable {
        programs.rofi = {
            enable = true;
        };
        xdg.configFile."rofi/config.rasi".source = ./config.rasi;
        xdg.configFile."rofi/themes/theme.rasi".source = ./themes/theme.rasi;
    };
}
