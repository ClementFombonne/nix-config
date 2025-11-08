{
  inputs,
  pkgs,
  config,
  ...
}:

{
  imports = [
    ./direnv
    ./git
    ./packages
    ./gemini-cli
  ];
}
