{
  pkgs,
  lib,
  config,
  ...
}:

with lib;
let
  cfg = config.modules.tmux;

in
{
  options.modules.tmux = {
    enable = mkEnableOption "tmux";
  };
  config = mkIf cfg.enable {
    programs.tmux = {
      enable = true;
      clock24 = true;
      shortcut = "q";
      keyMode = "vi";
      baseIndex = 1;
      plugins = with pkgs.tmuxPlugins; [
        sensible
        catppuccin
        vim-tmux-navigator
      ];
    };
  };
}
