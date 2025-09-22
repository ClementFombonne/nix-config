{ pkgs, lib, config, ... }:

with lib;
let cfg = config.modules.nmgui;

in {
    options.modules.nmgui = { enable = mkEnableOption "nmgui"; };
    config = mkIf cfg.enable {
        environment.systemPackages = with pkgs; [
            nmgui
        ]
    };
}

