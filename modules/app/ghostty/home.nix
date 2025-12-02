{
  pkgs,
  lib,
  osConfig,
  mkSymlink,
  ...
}:

with lib;
let
  cfg = osConfig.modules.ghostty;
  modulePath = "modules/app/ghostty";
in
{
  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      ghostty
    ];
    xdg.configFile."ghostty/config".source = mkSymlink "${modulePath}/config";
  };
}
