{ pkgs, lib, config, ... }:

with lib;
let cfg = config.modules.vs-code;

in {
  options.modules.vs-code = { enable = mkEnableOption "vs-code"; };
  config = mkIf cfg.enable {
    programs.vscode = {
      enable = true;
      extensions = with pkgs.vscode-extensions; [
        ms-vscode-remote.remote-ssh
        ms-vscode.remote-explorer
        vscodevim.vim
        ms-vscode.cpptools
        ms-python.python
        charliermarsh.ruff
      ];
    };
    environment.sessionVariables.NIXOS_OZONE_WL = "1";
  };
}
