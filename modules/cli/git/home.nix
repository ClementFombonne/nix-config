{
  pkgs,
  lib,
  config,
  osConfig,
  ...
}:

with lib;
let
  cfg = osConfig.modules.git;

in
{
  options.modules.git = {
    enable = mkEnableOption "git";
  };
  config = mkIf cfg.enable {
    programs.git = {
      enable = true;
      settings = {
        user.name = "clement fombonne";
        user.email = "clement.fombonne@proton.me";
        init = {
          defaultBranch = "main";
        };
        core = {
          excludesfile = "$NIXOS_CONFIG_DIR/scripts/gitignore";
        };
      };
    };
  };
}
