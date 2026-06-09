{
  pkgs,
  lib,
  config,
  inputs,
  ...
}:

with lib;
let
  cfg = config.modules.noctalia-shell;

in
{
  options.modules.noctalia-shell = {
    enable = mkEnableOption "noctalia-shell";
  };
  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default
      gpu-screen-recorder
      xdg-desktop-portal
    ];
  };
}
