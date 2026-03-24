{
  pkgs,
  lib,
  config,
  ...
}:

with lib;
let
  cfg = config.modules.proton-tools;

in
{
  options.modules.proton-tools = {
    enable = mkEnableOption "proton-tools";
  };
  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      proton-vpn-cli
      proton-pass-cli
      proton-authenticator
    ];
  };
}
