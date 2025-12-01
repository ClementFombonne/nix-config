{
  inputs,
  pkgs,
  config,
  osConfig,
  ...
}:

{
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
