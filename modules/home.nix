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
  home.file.".config/wallpaper/glass.jpg".source = ../assets/wallpaper.jpg;
  home.file.".config/wallpaper/glass.png".source = ../assets/wallpaper.png;
}
