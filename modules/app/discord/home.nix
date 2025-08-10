{ pkgs, lib, config, osConfig, ... }:

with lib;
let cfg = osConfig.modules.discord;

in {
    config = mkIf cfg.enable {
    };
}
