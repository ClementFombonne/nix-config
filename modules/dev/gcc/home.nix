{ pkgs, lib, config, osConfig, ... }:

with lib;
let cfg = osConfig.modules.gcc;

in {
    config = mkIf cfg.enable {
    };
}
