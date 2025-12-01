{ pkgs, lib, config, osConfig, ... }:

with lib;
let cfg = osConfig.modules.wofi;

in {
    config = mkIf cfg.enable {
        programs.wofi.enable = true;
        xdg.configFile."wofi/style.css".source = ./wofi.css;
    };
}
