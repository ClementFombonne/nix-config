{
  pkgs,
  lib,
  config,
  inputs,
  ...
}:

with lib;
let
  cfg = config.modules.noctalia-shell;
in
{
  options.modules.noctalia-shell = {
    enable = mkEnableOption "noctalia-shell";
  };

  imports = [
    inputs.noctalia-greeter.nixosModules.default
  ];

  config = mkIf cfg.enable {
    # Ensure dependencies are available
    environment.systemPackages = [
      inputs.noctalia.packages.${pkgs.system}.default
      pkgs.gpu-screen-recorder
      pkgs.xdg-desktop-portal
    ];

    # The greeter module handles the underlying 'greetd' service
    programs.noctalia-greeter = {
      enable = true;
      settings = {
        # cursor = {
        #   theme = "Bibata-Modern-Ice";
        #   size = 24;
        #   # Ensure this path is valid on your system
        #   path = "${pkgs.bibata-cursors}/share/icons";
        # };
        keyboard = {
          layout = "fr";
        };
      };
    };
  };
}
