{ inputs, pkgs, config, ... }:

{
    imports = [
        ./xdg
	    ./zsh
        ./oh-my-posh
        ./tmux
    ];
}
