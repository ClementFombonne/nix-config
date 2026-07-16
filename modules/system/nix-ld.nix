{ self, ... }: {
  flake.nixosModules.nix-ld = { pkgs, ... }: {
    programs.nix-ld = {
      enable = true;

      libraries = with pkgs; [
        stdenv.cc.cc
        zlib
        util-linux
        libusb1
        openssl
      ];
    };
  };
}
