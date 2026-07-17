{ self, ... }: {
  flake.nixosModules.desktop-theme = { pkgs, lib, ... }: {

    environment.systemPackages = with pkgs; [
      bibata-cursors
      papirus-icon-theme
      gnome-themes-extra
      adwaita-qt
      adwaita-qt6
    ];

    fonts.packages = with pkgs; [
      nerd-fonts.jetbrains-mono
    ];

    environment.variables = {
      XCURSOR_THEME = "Bibata-Modern-Ice";
      XCURSOR_SIZE = "25";
    };

    programs.dconf = {
      enable = true;
      profiles.user.databases = [
        {
          lockAll = false;
          settings = {
            "org/gnome/desktop/interface" = {
              gtk-theme = "Adwaita-dark";
              icon-theme = "Papirus-Dark";
              cursor-theme = "Bibata-Modern-Ice";
              cursor-size = lib.gvariant.mkInt32 25;
              font-name = "DejaVu Sans 12";
              color-scheme = "prefer-dark";
            };
          };
        }
      ];
    };

    qt = {
      enable = true;
      platformTheme = "gnome";
      style = "adwaita-dark";
    };
  };
}
