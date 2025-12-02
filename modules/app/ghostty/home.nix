{
  pkgs,
  lib,
  config,
  osConfig,
  ...
}:

with lib;
let
  cfg = osConfig.modules.ghostty;
  create_symlink = path: config.lib.file.mkOutOfStoreSymlink path;
in
{
  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      ghostty
    ];
    xdg.configFile."ghostty/config" = {
      source = create_symlink ./config;
      recursive = true;
    };
  };
}
