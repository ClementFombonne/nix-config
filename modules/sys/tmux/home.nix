{ pkgs, lib, config, osConfig, ... }:

with lib;
let cfg = osConfig.modules.tmux;

in {
    config = mkIf cfg.enable {
    };
}
