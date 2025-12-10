{
  config,
  lib,
  pkgs,
  ...
}:

with lib;

let
  cfg = config.modules.noctalia-sddm;

  # Define the dependencies your theme needs to render QML
  themeDependencies = with pkgs.kdePackages; [
    qt6ct # Styling
    qtsvg # Render SVG icons
    qtwayland # Wayland support
    qtdeclarative # Core QML
  ];
in
{
  options.modules.noctalia-sddm = {
    enable = mkEnableOption "Noctalia SDDM Theme";

    settings = mkOption {
      type = types.attrs;
      default = { };
      description = "Settings to override in theme.conf";
    };
  };

  config = mkIf cfg.enable {

    # 1. Ensure SDDM is enabled and using Qt6
    services.displayManager.sddm = {
      enable = true;
      package = pkgs.kdePackages.sddm; # Force Qt6 SDDM
      theme = "noctalia-sddm";

      # 2. INJECT DEPENDENCIES HERE
      # This makes these libs available to QML without polluting your system profile
      extraPackages = themeDependencies;
    };

    # 3. Create the Theme Package
    environment.systemPackages = [
      (pkgs.stdenv.mkDerivation {
        name = "noctalia-sddm";

        # Point this to your repo
        src = pkgs.fetchFromGitHub {
          owner = "your-github-user";
          repo = "noctalia-sddm";
          rev = "main";
          hash = "sha256-AAAAAAAAAAAAAAAAAAAA"; # Update this after first run
        };

        installPhase = ''
          mkdir -p $out/share/sddm/themes/noctalia-sddm
          cp -r * $out/share/sddm/themes/noctalia-sddm

          # 4. Inject the Config (Generated from Nix options)
          rm -f $out/share/sddm/themes/noctalia-sddm/theme.conf
          cp ${pkgs.writeText "theme.conf" (generators.toINI { } cfg.settings)} \
             $out/share/sddm/themes/noctalia-sddm/theme.conf
        '';
      })
    ];
  };
}
