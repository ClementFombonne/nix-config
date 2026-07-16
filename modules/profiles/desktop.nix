{ self, ... }: {
  flake.nixosModules.profile-desktop = { ... }: {
    imports = with self.nixosModules; [
      core
      audio
      bluetooth
      network
      hyprland
      zen-browser
      desktop-theme
    ];
  };
}
