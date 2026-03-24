{
  config,
  lib,
  pkgs,
  ...
}:

with lib;

let
  cfg = config.modules.noctalia-sddm;
in
{
  options.modules.noctalia-sddm = {
    enable = mkEnableOption "Noctalia SDDM Theme";
  };
  config = mkIf cfg.enable {
    services.displayManager.sddm.noctalia = {
      enable = true;
      # background = {
      #   dynamic = true;
      #   path = "/var/lib/sddm/noctalia/wallpaper.png";
      # };
      background = ../../../assets/wallpaper.png;
      colorScheme = "Catppuccin";
    };
  };
}
