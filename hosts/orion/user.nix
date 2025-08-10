{ config, lib, inputs, ...}:

{
    config.modules = {
        # gui
        firefox.enable = true;
        ghostty.enable = true;
        zen-browser.enable = true;
        discord.enable = true;
        # eww.enable = true;
        # dunst.enable = true;
	    sddm.enable = true;
        hyprland.enable = true;
	    waybar.enable = true;
        rofi.enable = true;

        # cli
        nvim.enable = true;
        zsh.enable = true;
        oh-my-posh.enable = true;
        git.enable = true;
        # direnv.enable = true;

        # system
        xdg.enable = true;
        packages.enable = true;
    };
}
