{
  inputs,
  pkgs,
  config,
  ...
}:

{
  imports = [
    ./apptainer/home.nix
  ];
}
