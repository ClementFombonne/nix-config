{
  inputs,
  lib,
  config,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.modules.obs;

in
{
  options.modules.obs = {
    enable = mkEnableOption "obs";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      obs-studio
      obs-do
    ];
  };
}
