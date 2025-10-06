{ pkgs, lib, config, osConfig, ... }:

with lib;
let cfg = osConfig.modules.PROGRAM;

in {
    config = mkIf cfg.enable {
    };
}
