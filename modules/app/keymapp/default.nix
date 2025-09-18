{ pkgs, lib, config, ... }:

with lib;
let cfg = config.modules.keymapp;

in {
    options.modules.discord = { enable = mkEnableOption "keymapp"; };
    config = mkIf cfg.enable {
        environment.systemPackages = with pkgs; [
            keymapp
        ];
    };
}
