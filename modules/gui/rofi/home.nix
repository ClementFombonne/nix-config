{ pkgs, lib, config, osConfig, ... }:

with lib;
let cfg = osConfig.modules.rofi;

in {
    config = mkIf cfg.enable {
    };
}
