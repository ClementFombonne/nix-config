{ inputs, pkgs, lib, config, ... }:

with lib;
let cfg = config.modules.sddm;

in {
    options.modules.sddm = { enable = mkEnableOption "sddm"; };
    config = mkIf cfg.enable {
        environment.systemPackages = with pkgs; [(
            sddm-astronaut.override {
                themeConfig = {
                    Background = "/home/clement/.config/wallpaper/glass.png";
                    ScreenWidth = "3072";
                    ScreenHeight = "1920";
                };
            }
	    )];
        services.xserver.enable = true;
        services.displayManager.sddm = {
            enable = true;
            theme = "sddm-astronaut-theme";
	        package = pkgs.kdePackages.sddm;
            extraPackages = [ pkgs.sddm-astronaut ];
        };
    };
}
