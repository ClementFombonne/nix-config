{
  description = "NixOS configuration";

  # All inputs for the system
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";

    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };

    nur = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-hardware = {
      url = "github:NixOS/nixos-hardware/master";
    };
    LazyVim = {
      url = "github:albertlarsan68/LazyVim-module";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixvim = {
      url = "github:nix-community/nixvim";
      # inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  # All outputs for the system (configs)
  outputs =
    {
      home-manager,
      nixpkgs,
      nur,
      nixos-hardware,
      nixvim,
      ...
    }@inputs:
    let
      system = "x86_64-linux"; # current system
      pkgs = inputs.nixpkgs.legacyPackages.x86_64-linux;
      lib = nixpkgs.lib;

      # This lets us reuse the code to "create" a system
      # Credits go to sioodmy on this one!
      # https://github.com/sioodmy/dotfiles/blob/main/flake.nix
      mkSystem =
        pkgs: system: hostname: model:
        pkgs.lib.nixosSystem {
          system = system;
          modules = [
            { networking.hostName = hostname; }
            # General configuration (users, networking, sound, etc)
            home-manager.nixosModules.home-manager
            nixos-hardware.nixosModules.${model}
            nixvim.nixosModules.nixvim
            # Personal configuration
            ./modules/default.nix
            ./modules/configuration.nix
            # Hardware config (bootloader, kernel modules, filesystems, etc)
            # DO NOT USE MY HARDWARE CONFIG!! USE YOUR OWN!!
            (./. + "/hosts/${hostname}/hardware-configuration.nix")
            (./. + "/hosts/${hostname}/default.nix")
            {
              home-manager = {
                useUserPackages = true;
                useGlobalPkgs = true;
                backupFileExtension = "old";
                extraSpecialArgs = { inherit inputs; };
                # Home manager config (configures programs like firefox, zsh, eww, etc)
                users.clement = (./. + "/modules/home.nix");
              };
            }
          ];
          specialArgs = { inherit inputs; };
        };

    in
    {
      nixosConfigurations = {
        # Now, defining a new system is can be done in one line
        #                               Architecture   Hostname
        orion = mkSystem inputs.nixpkgs "x86_64-linux" "orion" "lenovo-yoga-7-14IAH7-integrated";
      };
    };
}
