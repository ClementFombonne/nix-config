{
  inputs,
  pkgs,
  lib,
  config,
  osConfig,
  ...
}:

with lib;
let
  cfg = osConfig.modules.neovim;

in
{
  options.modules.neovim = {
    enable = mkEnableOption "neovim";
  };
  config = mkIf cfg.enable {
    programs.neovim = {
      enable = true;
      viAlias = true;
      vimAlias = true;
      defaultEditor = true;
      withPython3 = false;
      withRuby = false;
      plugins = with pkgs.vimPlugins; [
        catppuccin-nvim
        mini-nvim
        nvim-treesitter.withAllGrammars
        blink-cmp
        snacks-nvim
        noice-nvim
        conform-nvim
        lazygit-nvim
      ];
    };
    xdg.configFile."nvim".source =
      config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.config/dotfiles/neovim";
  };
}
