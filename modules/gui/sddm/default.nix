{ inputs, pkgs, lib, config, ... }:

with lib;
let cfg = config.modules.sddm;

in {
    options.modules.sddm = { enable = mkEnableOption "sddm"; };
    config = mkIf cfg.enable {
        environment.systemPackages = with pkgs; [(
	    catppuccin-sddm.override {
                flavor = "frappe";
                font  = "Noto Sans";
                fontSize = "12";
                background = "${../../../assets/wallpaper.jpg}";
                loginBackground = true;
            }
	)];
        services.xserver.enable = true;
        services.displayManager.sddm = {
            enable = true;
            theme = "catppuccin-frappe";
	    package = pkgs.kdePackages.sddm;
        };
    };
}
