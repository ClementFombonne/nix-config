{ self, ... }: {
  flake.nixosModules.ghostty = { pkgs, ... }: {
    imports = [
      self.nixosModules.cli-utils
    ];
    fonts.packages = with pkgs; [ nerd-fonts.jetbrains-mono ];

    # Automatically wire the Home Manager configuration for your user
    home-manager.users.clement.imports = [ self.homeModules.ghostty ];
  };

  flake.homeModules.ghostty = { pkgs, ... }: {
    home.packages = [ pkgs.ghostty ];

    xdg.configFile."ghostty/config".text = ''
      theme = noctalia
      background-opacity = 0.60
      background-blur = true
      font-family = "JetBrains Mono"
      font-size = 14
      confirm-close-surface = false
      mouse-hide-while-typing = true
      window-padding-x = 10
      window-padding-y = 10
      gtk-single-instance = true
    '';
  };
}
