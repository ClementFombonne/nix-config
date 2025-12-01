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
  imports = [
    inputs.noctalia.nixosModules.default
  ];
  config = mkIf cfg.enable {
    services.noctalia-shell.enable = true;
  };
}
