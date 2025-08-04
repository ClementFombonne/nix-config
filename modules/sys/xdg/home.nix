{ pkgs, lib, config, osConfig, ... }:

with lib;
let cfg = osConfig.modules.xdg;

in {
    config = mkIf cfg.enable {
        xdg.userDirs = {
            enable = true;
            documents = "$HOME/Data/documents/";
            download = "$HOME/Data/download/";
            videos = "$HOME/Data/videos/";
            music = "$HOME/Data/music/";
            pictures = "$HOME/Data/pictures/";
            desktop = "$HOME/Data/documents/";
            publicShare = "$HOME/Data/documents/";
            templates = "$HOME/Data/documents/";
        };
    };
}
