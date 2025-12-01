{ pkgs, lib, config, osConfig, ... }:

with lib;
let cfg = osConfig.modules.ghostty;

in {
    config = mkIf cfg.enable {
	home.packages = with pkgs; [
	    ghostty
	];
        xdg.configFile."ghostty/config".source = ./config;
    };
}
