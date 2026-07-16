{ self, ... }: {
  flake.nixosModules.hyprland = { pkgs, ... }: {
    imports = [
      self.nixosModules.noctalia-shell
    ];

    programs.hyprland = {
      enable = true;
      xwayland.enable = true;
    };

    environment.systemPackages = with pkgs; [
      brightnessctl
      pavucontrol
      playerctl
      hyprshot
    ];

    environment.sessionVariables.NIXOS_OZONE_WL = "1";

    home-manager.users.clement.imports = [ self.homeModules.hyprland ];
  };

  flake.homeModules.hyprland =
    {
      pkgs,
      lib,
      osConfig,
      ...
    }:
    let
      monitors = osConfig.hardware.monitors or [ ];

      generateLuaMonitor = m: ''
        hl.monitor({
          output = "${m.name}",
          mode = "${toString m.width}x${toString m.height}@${toString m.refreshRate}",
          position = "${toString m.x}x${toString m.y}",
          scale = ${toString m.scale},
          transform = ${toString (m.transform or 0)}
        })
      '';

      monitorConfigText = lib.concatStringsSep "\n" (map generateLuaMonitor monitors);
    in
    {
      home.packages = [ pkgs.hyprshot ];

      xdg.configFile."hypr/hyprland.lua".source = ./hyprland.lua;
      xdg.configFile."hypr/conf/keybinds.lua".source = ./keybinds.lua;
      xdg.configFile."hypr/conf/monitor.lua".text = monitorConfigText;
    };
}
