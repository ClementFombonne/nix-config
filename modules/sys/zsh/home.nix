{ pkgs, lib, config, osConfig, ... }:
with lib;
let cfg = osConfig.modules.zsh;
in {
    config = mkIf cfg.enable {
        programs.zsh = {
            enable = true;  # Enable Zsh
            oh-my-zsh = {
                enable = true; 
                theme = "fino"; 
                plugins = [
                    "git"
	            "sudo"
	            "copyfile"
                ];
            };
        };
    };
}
