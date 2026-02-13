{
  inputs,
  lib,
  config,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.modules.vivaldi;

in
{
  options.modules.vivaldi = {
    enable = mkEnableOption "vivaldi";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      vivaldi
    ];
  };
}
