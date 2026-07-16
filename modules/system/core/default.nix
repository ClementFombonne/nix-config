{ self, ... }: {
  flake.nixosModules.core = { pkgs, ... }: {
    imports = [
      self.nixosModules.core-boot
      self.nixosModules.core-nix
      self.nixosModules.core-user
      self.nixosModules.core-locale
    ];
    services = {
      openssh = {
        enable = true;
        settings = {
          PermitRootLogin = "no";
          PasswordAuthentication = false; # Best practice: enforce SSH keys
        };
      };

      avahi = {
        enable = true;
        nssmdns4 = true;
        publish = {
          enable = true;
          addresses = true;
          workstation = true;
        };
      };

      gvfs.enable = true;
    };

    environment.systemPackages = with pkgs; [
      # core pacakges
      usbutils
      lsof
      acpi
      file
      # core tool
      vim
      zip
      unzip
      python3
    ];
  };
}
