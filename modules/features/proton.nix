{ self, ... }: {
  flake.nixosModules.obsidian = { pkgs, ... }: {
    environment.systemPackages = with pkgs; [
      proton-vpn-cli
      proton-pass-cli
      proton-authenticator
    ];
  };
}
