{ self, ... }: {
  flake.nixosModules.monitors = { lib, config, ... }: {
    options.hardware.monitors = lib.mkOption {
      description = "System monitor configuration";
      default = [ ];
      type = lib.types.listOf (
        lib.types.submodule {
          options = {
            name = lib.mkOption {
              type = lib.types.str;
              example = "DP-1";
            };
            width = lib.mkOption {
              type = lib.types.int;
              example = 1920;
            };
            height = lib.mkOption {
              type = lib.types.int;
              example = 1080;
            };
            refreshRate = lib.mkOption {
              type = lib.types.float;
              default = 60.0;
            };
            x = lib.mkOption {
              type = lib.types.int;
              default = 0;
            };
            y = lib.mkOption {
              type = lib.types.int;
              default = 0;
            };
            scale = lib.mkOption {
              type = lib.types.float;
              default = 1.0;
            };
            transform = lib.mkOption {
              type = lib.types.int;
              default = 0;
            };
            primary = lib.mkOption {
              type = lib.types.bool;
              default = false;
            };
          };
        }
      );
    };
  };
}
