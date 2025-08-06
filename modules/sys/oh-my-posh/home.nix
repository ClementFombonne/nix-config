{ pkgs, lib, config, osConfig, ... }:

with lib;
let cfg = osConfig.modules.oh-my-posh;

in {
    config = mkIf cfg.enable {
        programs.oh-my-posh = {
            enable = true;
            settings = builtins.fromTOML (builtins.readFile ./zen.toml);
        };
    };
}
