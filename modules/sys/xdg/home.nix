{
  pkgs,
  lib,
  config,
  osConfig,
  ...
}:

with lib;
let
  cfg = osConfig.modules.xdg;

in
{
  config = mkIf cfg.enable {
    xdg = {
      configHome = "/home/clement/.config/";
      userDirs = {
        enable = true;
        documents = "$HOME/documents/";
        desktop = "$HOME/documents/";
        download = "$HOME/download/";
        videos = "$HOME/media/videos/";
        pictures = "$HOME/media/pictures/";
        music = "$HOME/media/music/";
        templates = "$HOME/.template/";
        publicShare = "$HOME/public/";
      };
    };
  };
}
