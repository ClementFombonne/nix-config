-- ======================
-- Basic Options
-- ======================
vim.opt.relativenumber = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- ======================
-- Theme: Catppuccin
-- ======================
require("catppuccin").setup({
    flavour = "frappe",
    transparent_background = true,
    integrations = {
        mini = true,
        native_lsp = { enabled = true },
    },
})
vim.cmd.colorscheme "catppuccin"

-- ======================
-- Noice
-- ======================
require('noice').setup({
    command_palette = true,
})

-- ======================
-- GitSigns
-- ======================
require('gitsigns').setup()

-- ======================
-- Mini.nvim modules
-- ======================
require('mini.basics').setup()
require('mini.pairs').setup()
require('mini.files').setup()
require('mini.git').setup()
require('mini.bracketed').setup()
-- require('mini.snippets').setup()
require('mini.starter').setup()
require('mini.statusline').setup()
require('mini.icons').setup()
require('mini.tabline').setup()
require('mini.indentscope').setup()

-- Open mini.files at current file
vim.keymap.set('n', '<leader>f', function()
    require('mini.files').open(vim.api.nvim_buf_get_name(0))
end, { desc = 'Open mini.files at current file' })

-- ======================
-- nvim-cmp Setup
-- ======================
local cmp = require('cmp')
local luasnip = require('luasnip')

cmp.setup({
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end,
    },
    mapping = cmp.mapping.preset.insert({
        ['<C-d>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<CR>'] = cmp.mapping.confirm({ select = true }),
        ['<Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            else
                fallback()
            end
        end, { 'i', 's' }),
        ['<S-Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, { 'i', 's' }),
    }),
    sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
        { name = 'buffer' },
        { name = 'path' },
    }),
})

-- ======================
-- LSP & Diagnostics
-- ======================
local lspconfig = require('lspconfig')

-- Floating diagnostics config
vim.diagnostic.config({
    virtual_text = false,
    signs = true,
    underline = true,
    update_in_insert = false,
    severity_sort = true,
    float = {
        border = 'rounded',
        source = 'always',
    },
})

vim.o.updatetime = 250
vim.cmd [[autocmd CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, { focusable = false })]]

-- Diagnostics keymaps
local opts = { noremap = true, silent = true }
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, opts)

-- LSP on_attach
local on_attach = function(client, bufnr)

    -- LSP keymaps
    local bufmap = function(mode, lhs, rhs)
        vim.keymap.set(mode, lhs, rhs, { buffer = bufnr })
    end
    bufmap('n', 'gd', vim.lsp.buf.definition)
    bufmap('n', 'K', vim.lsp.buf.hover)
    bufmap('n', 'gi', vim.lsp.buf.implementation)
    bufmap('n', '<leader>rn', vim.lsp.buf.rename)
    bufmap('n', '<leader>ca', vim.lsp.buf.code_action)
    bufmap('n', 'gr', vim.lsp.buf.references)
    bufmap('n', '<leader>f', vim.lsp.buf.formatting)
end

-- Setup LSP servers with nvim-cmp capabilities
local capabilities = require('cmp_nvim_lsp').default_capabilities()
lspconfig.lua_ls.setup({ on_attach = on_attach, capabilities = capabilities })
lspconfig.pyright.setup({ on_attach = on_attach, capabilities = capabilities })
lspconfig.rust_analyzer.setup({ on_attach = on_attach, capabilities = capabilities })
lspconfig.clangd.setup({ on_attach = on_attach, capabilities = capabilities })

