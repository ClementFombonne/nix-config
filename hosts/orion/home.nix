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
  cfg = osConfig.modules;
  nixosConfigPath = "${config.home.homeDirectory}/.config/nixos/";
  mkSymlink = path: config.lib.file.mkOutOfStoreSymlink "${nixosConfigPath}/${path}";
  modulePath = "hosts/orion/config";
in
{
  config = mkIf cfg.hyprland.enable {
    xdg.configFile."hypr/conf/monitor.lua".source = mkSymlink "${modulePath}/monitor.lua";
  };
}
