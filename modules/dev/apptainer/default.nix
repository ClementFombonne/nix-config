{ pkgs, lib, config, ... }:

with lib;
let cfg = config.modules.apptainer;

in {
    options.modules.apptainer = { enable = mkEnableOption "apptainer"; };
    config = mkIf cfg.enable {
        environment.systemPackages = with pkgs; [
            apptainer
        ];
    };
}
