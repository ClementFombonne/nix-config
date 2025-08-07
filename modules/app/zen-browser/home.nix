{ inputs, pkgs, lib, config, osConfig, ... }:

with lib;
let cfg = osConfig.modules.zen-browser;

in {
    config = mkIf cfg.enable {
        home.packages = [inputs.zen-browser.packages."${pkgs.system}".twilight];
    };
}
