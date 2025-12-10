{
  pkgs,
  lib,
  config,
  ...
}:

with lib;
let
  cfg = config.modules.niri;

in
{
  options.modules.niri = {
    enable = mkEnableOption "niri";
  };
  config = mkIf cfg.enable {
    programs.niri = {
      enable = true;
    };
    environment.systemPackages = with pkgs; [
      xwayland-satellite
      swayidle
      brightnessctl
      pavucontrol
      playerctl
    ];
    environment.sessionVariables.NIXOS_OZONE_WL = "1";
  };
}
