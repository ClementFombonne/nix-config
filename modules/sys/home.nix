{ inputs, pkgs, config, ... }:

{
    imports = [
        ./xdg/home.nix
	./zsh/home.nix
    ];
}
