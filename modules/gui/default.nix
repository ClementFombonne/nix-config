{
  lib,
  ...
}:

let
  dirContents = builtins.readDir ./.;

  # Helper function to check if a directory contains default.nix
  hasDefaultNix =
    name: type: type == "directory" && builtins.pathExists (./. + "/${name}/default.nix");

  # Filter directories that actually have a default.nix
  validDirs = lib.filterAttrs hasDefaultNix dirContents;

  # Create the paths
  importPaths = map (name: ./. + "/${name}") (builtins.attrNames validDirs);
in
{
  imports = importPaths;
}
