{
  inputs,
  pkgs,
  lib,
  config,
  osConfig,
  mkSymlink,
  ...
}:

with lib;
let
  cfg = osConfig.modules.niri;
  modulePath = "modules/gui/niri";
in
{
  config = mkIf cfg.enable {
    xdg.configFile."niri/config.kdl".source = mkSymlink "${modulePath}/config.kdl";
  };
}
