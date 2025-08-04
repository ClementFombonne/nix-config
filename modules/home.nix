{ inputs, pkgs, config, osConfig, ... }:

{
    home.stateVersion = "25.05";
    imports = [
	./gui/home.nix
	./tui/home.nix
	./cli/home.nix
	./app/home.nix
	./dev/home.nix
	./sys/home.nix
    ];
}
