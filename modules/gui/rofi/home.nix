{
  pkgs,
  lib,
  config,
  osConfig,
  mkSymlink,
  ...
}:

with lib;
let
  cfg = osConfig.modules.rofi;
  modulePath = "modules/gui/rofi";
in
{
  config = mkIf cfg.enable {
    programs.rofi = {
      enable = true;
    };
    xdg.configFile."rofi/config.rasi".source = mkSymlink "${modulePath}/config.rasi";
    xdg.configFile."rofi/themes/theme.rasi".source = mkSymlink "${modulePath}/themes/theme.rasi";
  };
}
