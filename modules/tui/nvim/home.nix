{ inputs, pkgs, lib, config, osConfig, ... }:
with lib;
let
    cfg = osConfig.modules.nvim;
in {
    config = mkIf cfg.enable {
        programs.neovim = {
            enable = true;
            package = inputs.neovim-nightly-overlay.packages.${pkgs.system}.default;
            viAlias = true;
            vimAlias = true;
            plugins = with pkgs.vimPlugins; [
                catppuccin-nvim
                noice-nvim
                gitsigns-nvim
                nvim-lspconfig
                mini-nvim
                nvim-cmp
                cmp-nvim-lsp
                cmp-buffer
                cmp-path
                cmp_luasnip
                luasnip
            ];
            extraPackages = with pkgs; [
                lua-language-server
                pyright
                rust-analyzer
                clang-tools
            ];
        };
        home.file.".config/nvim/init.lua".source = ./init.lua;
    };
}
