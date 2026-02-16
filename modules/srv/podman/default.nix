{
  pkgs,
  lib,
  config,
  ...
}:

with lib;
let
  cfg = config.modules.podman;
in
{
  options.modules.podman = {
    enable = mkEnableOption "podman";
  };
  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      podman
    ];
  };
}
