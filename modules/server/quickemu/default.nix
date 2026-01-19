{
  pkgs,
  lib,
  config,
  ...
}:

with lib;
let
  cfg = config.modules.quickemu;

in
{
  options.modules.quickemu = {
    enable = mkEnableOption "quickemu";
  };
  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      quickemu
    ];
  };
}
