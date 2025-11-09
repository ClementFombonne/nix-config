{
  inputs,
  pkgs,
  config,
  ...
}:

{
  imports = [
    ./firefox
    ./ghostty
    ./zen-browser
    ./discord
    ./obsidian
    ./keymapp
    ./signal
    ./vs-code
    ./steam
    ./brave
  ];
}
