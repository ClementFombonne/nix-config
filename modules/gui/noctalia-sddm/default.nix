{
  config,
  lib,
  pkgs,
  ...
}:

with lib;

let
  cfg = config.modules.noctalia-sddm;

  toSddmVal = v: if builtins.isBool v then (if v then "true" else "false") else toString v;

  bgFileName = if cfg.background != null then builtins.baseNameOf cfg.background else "noctalia.png";

  bgConfigValue = "Assets/Wallpaper/${bgFileName}";

  # Define the dependencies your theme needs to render QML
  themeDependencies = with pkgs.kdePackages; [
    qt6ct # Styling
    qtsvg # Render SVG icons
    qtwayland # Wayland support
    qtdeclarative # Core QML
  ];

  finalThemeConfig = {
    General = {
      background = bgConfigValue;
      colorScheme = cfg.colorScheme;
      darkMode = toSddmVal cfg.darkMode;
      hideShadow = toSddmVal cfg.hideShadow;

      fontFamily = cfg.fontFamily;
      clockStyle = cfg.clockStyle;

      # Map nested scaling options to flat INI keys
      fontScale = toSddmVal cfg.scaling.font;
      radiusRatio = toSddmVal cfg.scaling.radius;
      iRadiusRatio = toSddmVal cfg.scaling.iRadius;
      screenRadiusRatio = toSddmVal cfg.scaling.screenRadius;
      scaleRatio = toSddmVal cfg.scaling.scale;
      animationSpeed = toSddmVal cfg.scaling.animationSpeed;

      # Allow users to inject extra keys (like colors) if needed
    }
    // cfg.extraSettings;
  };
in
{
  options.modules.noctalia-sddm = {
    enable = mkEnableOption "Noctalia SDDM Theme";

    background = mkOption {
      type = types.nullOr types.path;
      default = null;
      description = ''
        Path to a custom wallpaper file. 
        If set to null (default), the theme uses its built-in wallpaper (noctalia.png) 
        and no file copying occurs.
      '';
    };

    colorScheme = mkOption {
      type = types.str;
      default = "Noctalia-default";
      description = "ColorScheme selector.";
    };

    darkMode = mkOption {
      type = types.bool;
      default = true;
      description = "Enable DarkMode.";
    };

    hideShadow = mkOption {
      type = types.bool;
      default = false;
      description = "Hide background shadow.";
    };

    fontFamily = mkOption {
      type = types.str;
      default = "Roboto";
      description = "Font family used in the interface.";
    };

    clockStyle = mkOption {
      type = types.enum [
        "digital"
        "analog"
      ];
      default = "digital";
      description = "Clock widget style.";
    };

    scaling = {
      font = mkOption {
        type = types.float;
        default = 1.0;
        description = "Scaling factor for text.";
      };
      radius = mkOption {
        type = types.float;
        default = 1.0;
        description = "Scaling factor corner radius.";
      };
      iRadius = mkOption {
        type = types.float;
        default = 1.0;
        description = "Scaling factor corner iRadius.";
      };
      screenRadius = mkOption {
        type = types.float;
        default = 1.0;
        description = "Scaling factor for screen radius";
      };
      scale = mkOption {
        type = types.float;
        default = 1.0;
        description = "Scaling factor for UI elements.";
      };
      animationSpeed = mkOption {
        type = types.float;
        default = 1.0;
        description = "Scaling factor for animation speed.";
      };
    };

    extraSettings = mkOption {
      type = types.attrs;
      default = { };
      description = "Extra raw settings to add to the [General] section of theme.conf";
    };
  };

  config = mkIf cfg.enable {

    # 1. Ensure SDDM is enabled and using Qt6
    services.displayManager.sddm = {
      enable = true;
      package = pkgs.kdePackages.sddm; # Force Qt6 SDDM
      theme = "noctalia-sddm";
      #wayland.enable = true;
      enableHidpi = false;

      # 2. INJECT DEPENDENCIES HERE
      # This makes these libs available to QML without polluting your system profile
      extraPackages = themeDependencies;
    };

    # 3. Create the Theme Package
    environment.systemPackages = [
      (pkgs.stdenv.mkDerivation {
        name = "noctalia-sddm";

        src = pkgs.fetchFromGitHub {
          owner = "ClementFombonne";
          repo = "sddm-noctalia-theme";
          rev = "main";
          hash = "sha256-/8ldztumxnC907lIIMCJTNYoP1K+YJe0st1Wmvl/TNw=";
        };

        installPhase = ''
          mkdir -p $out/share/sddm/themes/noctalia-sddm
          cp -r * $out/share/sddm/themes/noctalia-sddm

          # --- HANDLE CUSTOM BACKGROUND ---
          # Only run this block if the user provided a background path
          ${lib.optionalString (cfg.background != null) ''
            mkdir -p $out/share/sddm/themes/noctalia-sddm/Assets/Wallpaper
            cp ${cfg.background} $out/share/sddm/themes/noctalia-sddm/Assets/Wallpaper/${bgFileName}
          ''}

          rm -f $out/share/sddm/themes/noctalia-sddm/Commons/Settings.conf
          cp ${pkgs.writeText "theme.conf" (generators.toINI { } finalThemeConfig)} \
             $out/share/sddm/themes/noctalia-sddm/Commons/Settings.conf
        '';
      })
    ];
  };
}
