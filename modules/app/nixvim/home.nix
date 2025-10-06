{ inputs, pkgs, lib, config, osConfig, ... }:

with lib;
let cfg = osConfig.modules.nixvim;

in {
    imports = [ inputs.nixvim.homeModules.nixvim ] ;
    config = mkIf cfg.enable {
        programs.nixvim = {
            enable = true;
            colorschemes.catppuccin.enable = true;
            plugins.lualine.enable = true;
            globals = {
                mapleader = " ";
                maplocalleader = " ";
                have_nerd_font = true;
            };
            clipboard = {
                providers = {
                    wl-copy.enable = true;
                };
                register = "unnamedplus";
            };
            opts = {
                # number
                number = true;
                relativenumber = true;
                # tab
                expandtab = true;
                smartindent = true;
                breakindent = true;
                tabstop = 4;
                softtabstop = 4;
                showtabline = 4;
                shiftwidth = 4;

                cursorline = true;
                scrolloff = 6;
                cmdheight = 0;
                mouse = "a";
            };
        };
    };
}
