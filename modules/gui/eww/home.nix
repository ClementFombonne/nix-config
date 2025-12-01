{
  inputs,
  lib,
  config,
  osConfig,
  pkgs,
  ...
}:
with lib;
let
  cfg = osConfig.modules.eww;
in
{
  config = mkIf cfg.enable {
    # theres no programs.eww.enable here because eww looks for files in .config
    # thats why we have all the home.files

    # eww package
    home.packages = with pkgs; [
      eww-wayland
      pamixer
      brightnessctl
      (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
    ];

    # configuration
    xdg.configFile."eww/eww.scss".source = ./eww.scss;
    xdg.configFile."eww/eww.yuck".source = ./eww.yuck;

    # scripts
    xdg.configFile."eww/scripts/battery.sh" = {
      source = ./scripts/battery.sh;
      executable = true;
    };

    xdg.configFile."eww/scripts/wifi.sh" = {
      source = ./scripts/wifi.sh;
      executable = true;
    };

    xdg.configFile."eww/scripts/brightness.sh" = {
      source = ./scripts/brightness.sh;
      executable = true;
    };

    xdg.configFile."eww/scripts/workspaces.sh" = {
      source = ./scripts/workspaces.sh;
      executable = true;
    };

    xdg.configFile."eww/scripts/workspaces.lua" = {
      source = ./scripts/workspaces.lua;
      executable = true;
    };
  };
}
