{ inputs, lib, config, pkgs, ... }:
with lib;
let
    cfg = config.modules.obsidian;

in {
    options.modules.obsidian = { enable = mkEnableOption "obsidian"; };

    config = mkIf cfg.enable {
        environment.systemPackages = with pkgs; [
            obsidian
        ];
    };
}
