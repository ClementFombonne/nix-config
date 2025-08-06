{ pkgs, lib, config, ... }:

with lib;
let cfg = config.modules.oh-my-posh;

in {
    options.modules.oh-my-posh = { enable = mkEnableOption "oh-my-posh"; };
    config = mkIf cfg.enable {
    };
}
