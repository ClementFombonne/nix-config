{ inputs, pkgs, config, ... }:

{
    imports = [
        ./direnv/home.nix
	./git/home.nix
	./packages/home.nix
    ];
}
