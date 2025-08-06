{ inputs, pkgs, lib, config, osConfig, ... }:
with lib;
let
    cfg = osConfig.modules.nvim;
in {
    config = mkIf cfg.enable {
        programs.neovim = {
	    enable = true;
        package = inputs.neovim-nightly-overlay.packages.${pkgs.system}.default;
	    viAlias = true;
	    vimAlias = true;
	    plugins = with pkgs.vimPlugins; [
	        catppuccin-nvim
            noice-nvim
            gitsigns-nvim
	        mini-nvim
            mason-nvim
	    ];
	};
        home.file.".config/nvim/init.lua".source = ./init.lua;
    };
}
