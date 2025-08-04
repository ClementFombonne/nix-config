{ inputs, lib, config, pkgs, ... }:
with lib;
let
    cfg = config.modules.eww;
in {
    options.modules.eww = { enable = mkEnableOption "eww"; };
}
