{ inputs, ... }: {
  imports = [
    inputs.home-manager.flakeModules.home-manager
  ];

  config = {
    flake.nixosModules.baseHomeManager = { ... }: {
      imports = [
        inputs.home-manager.nixosModules.default
      ];

      home-manager = {
        useGlobalPkgs = true;
        useUserPackages = true;
      };
    };
  };

  config.systems = [
    "x86_64-linux"
    "aarch64-linux"
  ];
}
