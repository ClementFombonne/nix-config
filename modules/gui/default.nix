{
  inputs,
  pkgs,
  config,
  osConfig,
  ...
}:

{
  imports = [
    ../../packages/wallpaper.nix
    ./dunst
    ./eww
    ./hyprland
    ./sddm
    ./gdm
    ./waybar
    ./rofi
    ./nmgui
  ];
  services.wallpaper = {
    enable = true;
    image = ../../assets/wallpaper.jpg;
  };
}
