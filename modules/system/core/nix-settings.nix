{ self, inputs, ... }: {
  flake.nixosModules.core-nix = { lib, ... }: {
    nix = {
      settings = {
        allowed-users = [
          "root"
          "clement"
        ];

        # Enable flakes
        experimental-features = [
          "nix-command"
          "flakes"
        ];

        # Increase download buffer to prevent chunks dropping on fast connections
        download-buffer-size = 524288000;
      };

      # Force legacy nix commands to use our flake inputs
      nixPath = [ "nixpkgs=${inputs.nixpkgs}" ];

      # Automatically deduplicate the Nix store
      optimise.automatic = true;

      gc = {
        automatic = true;
        dates = "weekly";
        options = "--delete-older-than 14d --max-free 3";
      };
    };

    # Allow proprietary software globally
    nixpkgs.config.allowUnfree = true;
  };
}
