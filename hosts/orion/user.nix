{ config, lib, inputs, ...}:

{
    config.modules = {
        # app
        firefox.enable = true;
        ghostty.enable = true;
        obsidian.enable = true;
        zen-browser.enable = true;
        discord.enable = true;
        keymapp.enable = true;
        # dev
        python-uv.enable = true;
        gcc.enable = true;
        apptainer.enable = true 
        # gui
	    sddm.enable = true;
        # gdm.enable = true;
        hyprland.enable = true;
	    waybar.enable = true;
        rofi.enable = true;
        # eww.enable = true;
        # dunst.enable = true;

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
