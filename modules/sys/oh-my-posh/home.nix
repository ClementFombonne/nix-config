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
  cfg = osConfig.modules.oh-my-posh;
  modulePath = "modules/sys/oh-my-posh";
in
{
  config = mkIf cfg.enable {
    programs.oh-my-posh = {
      enable = true;
      configFile = "$HOME/.config/oh-my-posh/zen.toml";
    };
    xdg.configFile."oh-my-posh/zen.toml".source = mkSymlink "${modulePath}/zen.toml";
  };
}
