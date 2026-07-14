{ self, inputs, ... }: {

  flake.homeModules.clementModule = { pkgs, config, ... }: {
    home.stateVersion = "26.05";
    xdg = {
      enable = true;

      # XDG Base Directories
      cacheHome = "${config.home.homeDirectory}/.cache";
      configHome = "${config.home.homeDirectory}/.config";
      dataHome = "${config.home.homeDirectory}/.local/share";
      stateHome = "${config.home.homeDirectory}/.local/state";

      # XDG User Directories
      userDirs = {
        enable = true;
        createDirectories = true;
        download = "${config.home.homeDirectory}/download";
        desktop = "${config.home.homeDirectory}/documents";
        documents = "${config.home.homeDirectory}/documents";
        templates = "${config.home.homeDirectory}/documents/templates";
        projects = "${config.home.homeDirectory}/projects";
        music = "${config.home.homeDirectory}/media/music";
        pictures = "${config.home.homeDirectory}/media/pictures";
        videos = "${config.home.homeDirectory}/media/videos";
        publicShare = "${config.home.homeDirectory}/public";

        extraConfig = {
          XDG_SCREENSHOTS_DIR = "${config.home.homeDirectory}/media/screenshots";
          XDG_DEV_DIR = "${config.home.homeDirectory}/projects";
        };
      };

      # Optional: Initialize mimeApps handling for default applications
      mimeApps.enable = true;
    };
  };
}
