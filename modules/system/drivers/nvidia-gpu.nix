{ self, ... }: {
  flake.nixosModules.nvidia-gpu = { pkgs, config, ... }: {
    environment.systemPackages = [ pkgs.nvtopPackages.nvidia ];
    services.xserver.videoDrivers = [ "nvidia" ];

    hardware.graphics = {
      enable = true;
      enable32Bit = true;
    };

    hardware.nvidia = {
      modesetting.enable = true;

      powerManagement.enable = false;
      powerManagement.finegrained = false;

      open = true;

      nvidiaSettings = true;
      package = config.boot.kernelPackages.nvidiaPackages.stable;
    };
  };
}
