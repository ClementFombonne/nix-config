{ inputs, pkgs, lib, config, osConfig, ... }:

with lib;
let cfg = osConfig.modules.zen-browser;

in {
    config = mkIf cfg.enable {
        imports = [ inputs.zen-browser.homeModules.twilight ];
        programs.zen-browser = {
            enable = true;
        };
    };
}
