{ self, inputs, ... }: {
  flake.nixosModules.zen-browser = { ... }: {
    home-manager.users.clement.imports = [ self.homeModules.zen-browser ];
  };

  flake.homeModules.zen-browser = { pkgs, ... }: {
    home.packages = [
      inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.twilight
    ];
  };
}
