{ pkgs, lib, config, ... }:

with lib;
let cfg = 
    config.modules.packages;

in {
    options.modules.packages = { enable = mkEnableOption "packages"; };
    config = mkIf cfg.enable {
        environment.systemPackages = with pkgs; [
	    ffmpeg 
	    tealdeer
	    htop 
	    fzf
	    eza
            bat 
	    unzip 
	    pqiv
            wf-recorder 
	];
	environment.shellAliases = {
            ls = "eza --icons=auto";
	    ll = "eza --icons=auto -l --git --total-size";
	    l =  "eza --icons=auto -la";
	    tree = "eza --icons=auto --tree";
	};
    };
}
