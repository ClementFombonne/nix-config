{
  pkgs,
  lib,
  config,
  ...
}:

with lib;
let
  cfg = config.modules.plymouth;

in
{
  options.modules.plymouth = {
    enable = mkEnableOption "plymouth";
  };
  config = mkIf cfg.enable {
    boot = {

      plymouth = {
        enable = true;
        theme = "loader_2";
        themePackages = with pkgs; [
          (adi1090x-plymouth-themes.override {
            selected_themes = [ "loader_2" ];
          })
        ];
      };

      consoleLogLevel = 3;
      initrd.verbose = false;
      kernelParams = [
        "quiet"
        "splash"
        "boot.shell_on_fail"
        "udev.log_priority=3"
        "rd.systemd.show_status=auto"
      ];
      loader.timeout = 0;
    };
  };
}
