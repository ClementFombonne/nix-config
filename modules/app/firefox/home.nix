{ inputs, lib, config, osConfig, pkgs, ... }:
with lib;
let
    cfg = osConfig.modules.firefox;

in {
    config = mkIf cfg.enable {
        programs.firefox = {
            enable = true;

            # Install extensions from NUR
            # profiles.clement.extensions = with pkgs.nur.repos.rycee.firefox-addons; [
            #     decentraleyes
            #     ublock-origin
            #     clearurls
            #     sponsorblock
            #     darkreader
            #     h264ify
            #     df-youtube
            # ];
        };
    };
}
