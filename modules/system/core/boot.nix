{ self, lib, ... }: {
  flake.nixosModules.core-boot = { pkgs, ... }: {
    boot = {
      kernelPackages = pkgs.linuxPackages_latest;
      tmp.cleanOnBoot = true;

      loader = {
        timeout = lib.mkDefault 2;
        efi.canTouchEfiVariables = true;

        systemd-boot = {
          enable = true;
          configurationLimit = 15;
        };
      };
    };
  };
}
