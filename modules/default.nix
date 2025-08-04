{ inputs, pkgs, config, ... }:

{
    imports = [
	./gui
	./tui
	./cli
	./app
	./dev
	./sys
    ];
}
