{
  lib,
  inputs,
  pkgs,
  config,
  ...
}:

{
  imports = [
    ./apptainer
    ./language
    ./nixvim
  ];
}
