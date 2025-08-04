{ pkgs, lib, config, ... }:

with lib;
let cfg = config.modules.ghostty;

in {
    options.modules.ghostty = { enable = mkEnableOption "ghostty"; };
}
