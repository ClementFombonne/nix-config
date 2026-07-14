{ self, inputs, ... }: {
  flake.nixosModules.noctalia-shell = { pkgs, ... }: {
    imports = [
      inputs.noctalia-greeter.nixosModules.default
      inputs.noctalia.nixosModules.default
    ];

    environment.systemPackages = [
      pkgs.gpu-screen-recorder
      pkgs.xdg-desktop-portal
    ];

    programs.noctalia = {
      enable = true;
      recommendedServices.enable = true;
    };

    programs.noctalia-greeter = {
      enable = true;
      settings = {
        cursor = {
          theme = "Bibata-Modern-Ice";
          size = 25;
          path = "${pkgs.bibata-cursors}/share/icons";
        };
        keyboard = {
          layout = "fr";
        };
        appearance = {
          hide_logo = true;
        };
      };
    };
    home-manager.users.clement.imports = [ self.homeModules.noctalia ];
  };

  flake.homeModules.noctalia = { ... }: {
    xdg.configFile."noctalia/config.toml".source = ./config.toml;
  };
}
