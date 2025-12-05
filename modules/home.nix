{
  inputs,
  pkgs,
  config,
  osConfig,
  ...
}:
let
  nixosConfigPath = "${config.home.homeDirectory}/.config/nixos/";
  mkSymlink = path: config.lib.file.mkOutOfStoreSymlink "${nixosConfigPath}/${path}";
in
{
  _module.args = {
    inherit nixosConfigPath mkSymlink;
  };

  home.stateVersion = "25.05";
  imports = [
    ./gui/home.nix
    ./cli/home.nix
    ./app/home.nix
    ./dev/home.nix
    ./sys/home.nix
  ];

  xdg.configFile."wallpaper/glass.jpg".source = ../assets/wallpaper.jpg;
  xdg.configFile."wallpaper/glass.png".source = ../assets/wallpaper.png;
}
