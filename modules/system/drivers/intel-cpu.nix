{ self, ... }: {
  flake.nixosModules.intel-cpu = { lib, config, ... }: {
    hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
    boot.kernelModules = [ "kvm-intel" ];
  };
}
