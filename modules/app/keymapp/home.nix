{ pkgs, lib, config, osConfig, ... }:

with lib;
let cfg = osConfig.modules.keymapp;

in {
    config = mkIf cfg.enable {
    };
}
