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
      background = ../../../assets/wallpaper.png;
      colorScheme = "Catppuccin";
    };
  };
}
