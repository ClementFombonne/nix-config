{
  pkgs,
  lib,
  config,
  ...
}:

with lib;
let
  cfg = config.modules.rust;

in
{
  options.modules.rust = {
    enable = mkEnableOption "rust";
  };
  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      rust-bin.stable.latest
      rust-analyzer
      rustup
      clippy
      rustfmt
    ];
  };
}
