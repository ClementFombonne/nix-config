{
  pkgs,
  lib,
  config,
  ...
}:

with lib;
let
  cfg = config.modules.onlyoffice;

in
{
  options.modules.onlyoffice = {
    enable = mkEnableOption "onlyoffice";
  };
  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      onlyoffice-desktopeditors
    ];
  };
}
