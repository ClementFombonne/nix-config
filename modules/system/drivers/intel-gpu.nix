{ self, ... }: {
  flake.nixosModules.intel-gpu = { pkgs, ... }: {
    environment.systemPackages = [ pkgs.vulkan-tools ];

    boot = {
      kernelModules = [ "i915" ];
      initrd.kernelModules = [ "i915" ];
    };

    hardware.graphics = {
      enable = true;
      enable32Bit = true; # Added for Steam/Wine compatibility
      extraPackages = with pkgs; [
        intel-media-driver
        intel-vaapi-driver
        libvdpau-va-gl
        libva-vdpau-driver
        vpl-gpu-rt
      ];
    };
  };
}
