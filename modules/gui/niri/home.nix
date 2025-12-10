{
  pkgs,
  lib,
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
  };
}
