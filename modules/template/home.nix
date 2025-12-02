{
  pkgs,
  lib,
  osConfig,
  mkSymlink,
  ...
}:

with lib;
let
  cfg = osConfig.modules.PROGRAM;
  modulePath = "modules/TYPE/PROGRAM";
in
{
  config = mkIf cfg.enable {
  };
}
