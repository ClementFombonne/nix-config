{ pkgs, lib, config, ... }:

with lib;
let cfg = config.modules.python-uv;

in {
    options.modules.python-uv = { enable = mkEnableOption "python-uv"; };
    config = mkIf cfg.enable {
        environment.systemPackages = with pkgs; [
            uv
            python312
        ];
        programs.nix-ld.enable = true;
    };
}
