{
  pkgs,
  lib,
  config,
  ...
}:

with lib;
let
  cfg = config.modules.gemini-cli;

in
{
  options.modules.gemini-cli = {
    enable = mkEnableOption "gemini-cli";
  };
  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      gemini-cli
    ];
  };
}
