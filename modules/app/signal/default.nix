{ pkgs, lib, config, ... }:

with lib;
let cfg = config.modules.signal;

in {
    options.modules.signal = { enable = mkEnableOption "signal"; };
    config = mkIf cfg.enable {
        environment.systemPackages = with pkgs; [
            signal-desktop
        ];
    };
}
