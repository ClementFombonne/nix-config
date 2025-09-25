{ inputs, pkgs, lib, config, osConfig, ... }:
with lib;
let
    cfg = osConfig.modules.nvim;
in {
    imports = [ inputs.LazyVim.homeManagerModules.default ];
    config = mkIf cfg.enable {
        programs.lazyvim = {
            enable = true;
        };
        home.shellAliases = {
            vim = "nvim";
        };
    };
}
