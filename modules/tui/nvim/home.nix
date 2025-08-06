{ pkgs, lib, config, osConfig, ... }:
with lib;
let
    cfg = osConfig.modules.nvim;
in {
    config = mkIf cfg.enable {
        programs.neovim = {
	    enable = true;
	    viAlias = true;
	    vimAlias = true;
	    plugins = with pkgs.vimPlugins; [
	        catppuccin-nvim
	        mini-nvim
	    ];
	};
        home.file.".config/nvim/init.lua".source = ./init.lua;
    };
}
