{ pkgs, lib, config, ... }:

with lib;
let cfg = config.modules.ghostty;

in {
    options.modules.ghostty = { enable = mkEnableOption "ghostty"; };
    config = mkIf cfg.enable {
        fonts.packages = with pkgs; [ nerd-fonts.jetbrains-mono ];
    };
}
