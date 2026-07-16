{ self, ... }: {
  flake.nixosModules.profile-gaming = { ... }: {
    imports = with self.nixosModules; [
    ];
  };
}
