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
  cfg = osConfig.modules.tmux;
  modulePath = "modules/sys/tmux";
in
{
  config = mkIf cfg.enable {
    xdg.configFile.".tmux.conf".source = mkSymlink "${modulePath}/tmux.conf";
  };
}
