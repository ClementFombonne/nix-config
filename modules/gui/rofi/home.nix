{ pkgs, lib, config, osConfig, ... }:

with lib;
let cfg = osConfig.modules.rofi;

in {
    config = mkIf cfg.enable {
        programs.rofi = {
            enable = true;
            package = pkgs.rofi-wayland; 
	    plugins = with pkgs; [rofi-calc];
	};
	home.file.".config/rofi/config.rasi".source = ./config.rasi;
    };
}
