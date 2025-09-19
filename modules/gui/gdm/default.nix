{ pkgs, lib, config, ... }:

with lib;
let cfg = config.modules.gdm;

in {
    options.modules.gdm = { enable = mkEnableOption "gdm"; };
    config = mkIf cfg.enable {
        services.displayManager.gdm.enable = true;
    };
}
