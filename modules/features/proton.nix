{ self, ... }: {
  flake.nixosModules.proton-tools = { pkgs, ... }: {
    environment.systemPackages = with pkgs; [
      proton-vpn-cli
      proton-pass-cli
      proton-authenticator
    ];
  };
}
