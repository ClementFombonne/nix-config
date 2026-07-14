{ self, ... }: {
  flake.nixosModules.onlyoffice = { pkgs, ... }: {
    environment.systemPackages = with pkgs; [
      onlyoffice-desktopeditors
    ];
  };
}
