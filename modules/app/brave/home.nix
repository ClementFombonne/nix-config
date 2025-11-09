{
  inputs,
  lib,
  config,
  osConfig,
  pkgs,
  ...
}:
with lib;
let
  cfg = osConfig.modules.brave;

in
{
  config = mkIf cfg.enable {
  };
}
