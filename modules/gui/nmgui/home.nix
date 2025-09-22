{ pkgs, lib, config, osConfig, ... }:

with lib;
let cfg = osConfig.modules.nmgui;

in {
    config = mkIf cfg.enable {
    };
}
