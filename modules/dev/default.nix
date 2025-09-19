{ inputs, pkgs, config, ... }:

{
    imports = [
        ./python-uv
        ./gcc
        ./apptainer
    ];
}
