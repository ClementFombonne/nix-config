-- Config
vim.opt.relativenumber = true
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

-- MiniVim setup
require('mini.basics').setup()
require('mini.statusline').setup()
require('mini.pairs').setup()
require('mini.starter').setup()
require('mini.files').setup()
require('mini.icons').setup()
require('mini.git').setup()

vim.keymap.set('n', '<leader>f', function()
  require('mini.files').open(vim.api.nvim_buf_get_name(0))
end, { desc = 'Open mini.files at current file' })
