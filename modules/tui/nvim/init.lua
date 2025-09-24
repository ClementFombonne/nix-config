-- Config
vim.opt.relativenumber = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '


-- Setup Catppuccin
require("catppuccin").setup({
    flavour = "frappe", -- latte, frappe, macchiato, mocha
    transparent_background = true,
    integrations = {
        mini = true,
        native_lsp = { enabled = true },
    },
})

vim.cmd.colorscheme "catppuccin"

-- Setup Noice
require('noice').setup({
    command_palette = true   
})

-- gitsigns setup
require('gitsigns').setup()

-- Mason setup
require('mason').setup()

-- MiniVim setup
require('mini.basics').setup()
require('mini.pairs').setup()
require('mini.files').setup()
require('mini.git').setup()
require('mini.bracketed').setup()
require('mini.completion').setup()
require('mini.snippets').setup()
-- Appearance 
require('mini.starter').setup()
require('mini.statusline').setup()
require('mini.icons').setup()
require('mini.tabline').setup()
require('mini.indentscope').setup()

vim.keymap.set('n', '<leader>f', function()
  require('mini.files').open(vim.api.nvim_buf_get_name(0))
end, { desc = 'Open mini.files at current file' })
