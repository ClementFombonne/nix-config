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
  cfg = osConfig.modules.wofi;
  modulePath = "modules/gui/wofi";
in
{
  config = mkIf cfg.enable {
    programs.wofi.enable = true;
    xdg.configFile."wofi/style.css".source = mkSymlink "${modulePath}/wofi.css";
  };
}
