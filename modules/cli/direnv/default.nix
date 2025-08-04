{ pkgs, lib, config, ... }:

with lib;
let cfg = config.modules.direnv;

in {
    options.modules.direnv= { enable = mkEnableOption "direnv"; };
}
