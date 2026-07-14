{ self, inputs, ... }: {

  flake.nixosModules.orionConfiguration = { pkgs, ... }: {
    imports = [
      self.nixosModules.monitors
      self.nixosModules.orionHardware
    ];
    home-manager.users.clement = self.homeModules.clementModule;

    # Boot options
    boot = {
      kernelModules = [ "i915" ];
      initrd.kernelModules = [ "i915" ];
    };

    # Nix settings, auto cleanup and enable flakes
    nix = {
      settings.allowed-users = [ "clement" ];
    };

    hardware = {
      graphics.enable = true;
      graphics.extraPackages = with pkgs; [
        mesa
        intel-media-driver
        intel-vaapi-driver
        libvdpau-va-gl
        libva-vdpau-driver
        vpl-gpu-rt
      ];
      monitors = [
        {
          name = "DP-4";
          width = 1920;
          height = 1080;
          refreshRate = 143.85;
          x = 0;
          y = 0;
          scale = 1.0;
          transform = 1;
        }
        {
          name = "DP-1";
          width = 2560;
          height = 1440;
          refreshRate = 165.00;
          x = 1080;
          y = 0;
          scale = 1.25;
          primary = true;
        }
        {
          name = "eDP-1";
          width = 3072;
          height = 1920;
          refreshRate = 120.00;
          x = 3128;
          y = 0;
          scale = 2.0;
        }
      ];
    };
  };
}
