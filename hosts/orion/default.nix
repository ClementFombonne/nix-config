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
    vivaldi.enable = true;
    brave.enable = true;
    discord.enable = true;
    onlyoffice.enable = true;
    keymapp.enable = true;
    signal.enable = true;
    vs-code.enable = true;
    steam.enable = true;
    yt-music.enable = true;
    proton-tools.enable = true;
    obs.enable = true;
    # dev
    apptainer.enable = true;
    neovim.enable = true;
    language = {
      nix.enable = true;
      gcc.enable = true;
      python.enable = true;
      rust.enable = true;
      typst.enable = true;
      qt.enable = true;
      lua.enable = true;
    };
    # gui
    gtk.enable = true;
    plymouth.enable = true;
    hyprland.enable = true;
    niri.enable = true;
    noctalia-shell.enable = true;

    # cli
    zsh.enable = true;
    oh-my-posh.enable = true;
    git.enable = true;
    gemini-cli.enable = true;
    direnv.enable = true;

    # system
    xdg.enable = true;
    packages.enable = true;
    tmux.enable = true;
    # server
    quickemu.enable = true;
    podman.enable = true;
  };
}
