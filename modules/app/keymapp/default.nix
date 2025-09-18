{ pkgs, lib, config, ... }:

with lib;
let cfg = config.modules.keymapp;

in {
    options.modules.keymapp = { enable = mkEnableOption "keymapp"; };
    config = mkIf cfg.enable {
        environment.systemPackages = with pkgs; [
            keymapp
        ];
        hardware.keyboard.zsa.enable = true;
    };
}
