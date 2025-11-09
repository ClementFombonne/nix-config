{
  inputs,
  lib,
  config,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.modules.brave;

in
{
  options.modules.brave = {
    enable = mkEnableOption "brave";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      brave
    ];
  };
}
