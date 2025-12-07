{ lib, ... }:

let
  dirContents = builtins.readDir ./.;
  hasHomeNix = name: type: type == "directory" && builtins.pathExists (./. + "/${name}/home.nix");
  validDirs = lib.filterAttrs hasHomeNix dirContents;

  importPaths = map (name: ./. + "/${name}/home.nix") (builtins.attrNames validDirs);
in
{
  imports = importPaths;
}
