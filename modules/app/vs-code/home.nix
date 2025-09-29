{ pkgs, lib, config, osConfig, ... }:

with lib;
let cfg = osConfig.modules.vs-code;

in {
    config = mkIf cfg.enable {
    };
}
