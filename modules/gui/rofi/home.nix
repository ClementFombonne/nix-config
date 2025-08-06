{ pkgs, lib, config, osConfig, ... }:

with lib;
let cfg = osConfig.modules.rofi;

in {
    config = mkIf cfg.enable {
        programs.rofi = {
            enable = true;
            package = pkgs.rofi-wayland; 
            extraConfig = builtins.readFile ./config.rasi;
	};
        home.file.".config/rofi/theme/theme.rasi".source = ./theme/theme.rasi;
        home.file.".config/rofi/theme/colors.rasi".source = ./theme/colors.rasi;
        home.file.".config/rofi/theme/fonts.rasi".source = ./theme/fonts.rasi;
    };
}
