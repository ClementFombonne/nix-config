{ pkgs, lib, config, osConfig, ... }:

with lib;
let cfg = osConfig.modules.rofi;

in {
    config = mkIf cfg.enable {
        programs.rofi = {
            enable = true;
            package = pkgs.rofi-wayland; 
	    theme = ./theme/theme.rasi;
            extraConfig = {
	        modi = "drun,run,filebrowser,window,ssh";
                show-icons = true;
                display-drun = " Apps";
                display-run = " Run";
                display-filebrowser = " Files";
                display-window = " Windows";
            };
	};
        home.file.".config/rofi/themes/theme.rasi".source = ./theme/theme.rasi;
    };
}
