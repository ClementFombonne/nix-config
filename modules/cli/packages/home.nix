{
  pkgs,
  lib,
  config,
  osConfig,
  mkSymlink,
  ...
}:

with lib;
let
  cfg = osConfig.modules.packages;
  modulePath = "modules/cli/packages";

in
{
  config = mkIf cfg.enable {
    programs.zsh.shellGlobalAliases = {
      ls = "eza --icons=auto";
      ll = "eza --icons=auto -l --git --total-size";
      l = "eza --icons=auto -la";
      tree = "eza --icons=auto --tree";
      ff = "fastfetch --logo-type data --logo $(grep '^NAME=' /etc/os-release | cut -d'=' -f2 | tr -d '\"' | figlet -f slant)";
    };
    xdg.configFile."fastfetch/config.jsonc".source = mkSymlink "${modulePath}/config.jsonc";
  };
}
