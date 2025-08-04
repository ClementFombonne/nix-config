{ pkgs, lib, config, osConfig, ... }:

with lib;
let cfg = osConfig.modules.wofi;

in {
    config = mkIf cfg.enable {
        programs.wofi.enable = true;
        home.file.".config/wofi.css".source = ./wofi.css;
    };
}
