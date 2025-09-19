{ pkgs, lib, config, osConfig, ... }:

with lib;
let cfg = osConfig.modules.apptainer;

in {
    config = mkIf cfg.enable {
    };
}
