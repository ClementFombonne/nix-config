{
  config,
  lib,
  inputs,
  ...
}:

{
  config.modules = {
    # app
    firefox.enable = true;
    ghostty.enable = true;
    obsidian.enable = true;
    zen-browser.enable = true;
    brave.enable = true;
    discord.enable = true;
    keymapp.enable = true;
    signal.enable = true;
    vs-code.enable = true;
    steam.enable = true;
    # dev
    apptainer.enable = true;
    nixvim.enable = true;
    language = {
      gcc.enable = true;
      python.enable = true;
      rust.enable = true;
      typst.enable = true;
    };
    # gui
    sddm.enable = true;
    plymouth.enable = true;
    # gdm.enable = true;
    hyprland.enable = true;
    waybar.enable = true;
    rofi.enable = true;
    nmgui.enable = true;
    # eww.enable = true;
    # dunst.enable = true;

    # cli
    # nvim.enable = true;
    zsh.enable = true;
    oh-my-posh.enable = true;
    git.enable = true;
    gemini-cli.enable = true;
    direnv.enable = true;

    # system
    xdg.enable = true;
    packages.enable = true;
    tmux.enable = true;
    nvidia.enable = true;
  };
}
