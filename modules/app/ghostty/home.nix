{ pkgs, lib, config, osConfig, ... }:

with lib;
let cfg = osConfig.modules.ghostty;

in {
    config = mkIf cfg.enable {
	home.packages = with pkgs; [
	    ghostty
	];
        home.file.".config/ghostty/config".source = ./config;
    };
}
