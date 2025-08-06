{ inputs, pkgs, config, ... }:

{
    imports = [
        ./xdg/home.nix
	    ./zsh/home.nix
        ./oh-my-posh/home.nix
    ];
}
