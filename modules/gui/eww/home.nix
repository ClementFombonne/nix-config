{
  inputs,
  lib,
  config,
  osConfig,
  pkgs,
  mkSymlink,
  ...
}:
with lib;
let
  cfg = osConfig.modules.eww;
  modulePath = "modules/gui/eww";
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
    xdg.configFile."eww/eww.scss".source = mkSymlink "${modulePath}/eww.scss";
    xdg.configFile."eww/eww.yuck".source = mkSymlink "${modulePath}/eww.yuck";

    # scripts
    xdg.configFile."eww/scripts/battery.sh" = {
      source = mkSymlink "${modulePath}/scripts/battery.sh";
      executable = true;
    };

    xdg.configFile."eww/scripts/wifi.sh" = {
      source = mkSymlink "${modulePath}/scripts/wifi.sh";
      executable = true;
    };

    xdg.configFile."eww/scripts/brightness.sh" = {
      source = mkSymlink "${modulePath}/scripts/brightness.sh";
      executable = true;
    };

    xdg.configFile."eww/scripts/workspaces.sh" = {
      source = mkSymlink "${modulePath}/scripts/workspaces.sh";
      executable = true;
    };

    xdg.configFile."eww/scripts/workspaces.lua" = {
      source = mkSymlink "${modulePath}/scripts/workspaces.lua";
      executable = true;
    };
  };
}
