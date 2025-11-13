{
  inputs,
  pkgs,
  config,
  ...
}:

{
  imports = [
    ./gui
    ./cli
    ./app
    ./dev
    ./sys
  ];
}
