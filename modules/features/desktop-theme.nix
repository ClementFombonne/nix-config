{ self, ... }: {
  flake.nixosModules.desktop-theme = { ... }: {
    programs.dconf.enable = true;

    environment.sessionVariables = {
      XCURSOR_SIZE = "25";
    };

    home-manager.users.clement.imports = [ self.homeModules.desktop-theme ];
  };

  flake.homeModules.desktop-theme = { pkgs, ... }: {
    home.packages = with pkgs; [
      bibata-cursors
      papirus-icon-theme
      adwaita-qt
      adwaita-qt6
    ];

    home.pointerCursor = {
      enable = true;
      gtk.enable = true;
      x11.enable = true;
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Ice";
      size = 25;
    };

    gtk = {
      enable = true;
      font = {
        name = "DejaVu Sans";
        size = 12;
      };
      iconTheme = {
        name = "Papirus-Dark";
        package = pkgs.papirus-icon-theme;
      };
      cursorTheme = {
        name = "Bibata-Modern-Ice";
        package = pkgs.bibata-cursors;
      };
      theme = {
        name = "Adwaita-dark";
        package = pkgs.gnome-themes-extra;
      };
      gtk3.extraConfig.gtk-application-prefer-dark-theme = 1;
      gtk4.extraConfig.gtk-application-prefer-dark-theme = 1;
    };

    qt = {
      enable = true;
      platformTheme.name = "adwaita";
      style.name = "adwaita-dark";
    };
  };
}
