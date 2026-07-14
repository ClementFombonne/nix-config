{ self, ... }: {
  flake.nixosModules.steam = { ... }: {
    programs.steam = {
      enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
      gamescopeSession.enable = true;
    };

    hardware.graphics.enable32Bit = true;

    home-manager.users.clement.imports = [ self.homeModules.steam ];
  };

  flake.homeModules.steam = { pkgs, ... }: {
    home.packages = with pkgs; [
      gamescope
      mangohud
      protonup-qt
    ];

    home.sessionVariables = {
      STEAM_EXTRA_COMPAT_TOOLS_PATHS = "\${HOME}/.steam/root/compatibilitytools.d";
    };
  };
}
