{ pkgs, lib, config, osConfig, ... }:

with lib;
let cfg = osConfig.modules.python-uv;

in {
    options.modules.python-uv = { enable = mkEnableOption "python-uv"; };
    config = mkIf cfg.enable {
    };
}
