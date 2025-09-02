{ inputs, lib, config, osConfig, pkgs, ... }:
with lib;
let
    cfg = osConfig.modules.obsidian;

in {
    config = mkIf cfg.enable {
    };
}
