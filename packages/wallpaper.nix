{
  lib,
  config,
  pkgs,
  ...
}:

with lib;

let
  # -----------------------------------------------------------------
  # Helper: a tiny derivation that just copies the chosen file into
  #        $out/share/wallpaper/
  # -----------------------------------------------------------------
  wallpaperPackage =
    imagePath:
    pkgs.stdenv.mkDerivation {
      pname = "custom-wallpaper";
      version = "1.0";

      # `imagePath` is expected to be a store path (e.g. a file from the
      # NixOS config, fetched via `builtins.path` or `pkgs.runCommand`).
      src = imagePath;

      installPhase = ''
        mkdir -p $out/share/wallpaper
        # Preserve the original filename
        cp $src $out/share/wallpaper/
      '';

      # No runtime dependencies – just a plain file.
      meta = {
        description = "User‑provided wallpaper image";
        platforms = platforms.all;
      };
    };
in
{
  options.services.wallpaper = {
    enable = mkEnableOption "Install a custom wallpaper image into /run/current-system/sw/share/wallpaper/";

    # The user supplies a path relative to the NixOS configuration
    # directory (or an absolute store path).  We turn it into a store
    # path with `builtins.path` so it works both for plain files and
    # for files that are themselves the result of a fetcher.
    image = mkOption {
      type = types.path;
      description = ''
        Path to the image that should be copied into
        `/run/current-system/sw/share/wallpaper/`.  The path is taken
        relative to the directory that contains this NixOS configuration
        (or you can give an absolute store path).
      '';
      example = "./wallpapers/my‑wallpaper.jpg";
    };
  };

  config = mkIf config.services.wallpaper.enable {
    environment.systemPackages = [
      (wallpaperPackage config.services.wallpaper.image)
    ];

    environment.variables.WALLPAPER_DIR = "/run/current-system/sw/share/wallpaper";
  };
}
