{ self, inputs, ... }: {
  flake.nixosConfigurations.orion = inputs.nixpkgs.lib.nixosSystem {
    modules = with self.nixosModules; [
      baseHomeManager
      orionConfiguration
      profile-desktop
      intel-cpu
      intel-gpu
      nix-ld

      ghostty
      neovim
      steam
      obsidian
      onlyoffice
      discord
      media-utils
    ];
  };
}
