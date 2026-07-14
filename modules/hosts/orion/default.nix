{ self, inputs, ... }: {
  flake.nixosConfigurations.orion = inputs.nixpkgs.lib.nixosSystem {
    modules = [
      self.nixosModules.baseConfiguration
      self.nixosModules.baseHomeManager
      self.nixosModules.orionConfiguration

      self.nixosModules.ghostty
      self.nixosModules.neovim
      self.nixosModules.hyprland
      self.nixosModules.zen-browser
      self.nixosModules.steam
      self.nixosModules.obsidian
      self.nixosModules.onlyoffice
      self.nixosModules.discord
      self.nixosModules.media-utils
    ];
  };
}
