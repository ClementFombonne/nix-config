{
  pkgs,
  lib,
  config,
  osConfig,
  ...
}:

with lib;
let
  cfg = osConfig.modules.packages;

in
{
  config = mkIf cfg.enable {
    programs.zsh.shellGlobalAliases = {
      ls = "eza --icons=auto";
      ll = "eza --icons=auto -l --git --total-size";
      l = "eza --icons=auto -la";
      tree = "eza --icons=auto --tree";
    };
  };
  home.file.".config/fastfetch/config.jsonc".source = ./config.jsonc;
}
