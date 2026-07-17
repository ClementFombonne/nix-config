{ self, ... }: {
  flake.nixosModules.profile-development = { ... }: {
    imports = with self.nixosModules; [
      neovim
      development
    ];
  };
}
