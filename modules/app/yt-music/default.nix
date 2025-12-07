{
  pkgs,
  lib,
  config,
  ...
}:

with lib;
let
  cfg = config.modules.yt-music;

in
{
  options.modules.yt-music = {
    enable = mkEnableOption "yt-music";
  };
  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      youtube-music
    ];
  };
}
