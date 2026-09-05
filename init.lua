-- Lua モジュールのバイトコードキャッシュを有効化（起動高速化）
vim.loader.enable()

-- visual
-- vim.cmd[[colorscheme torte]]
vim.o.number = true
vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.o.cursorline = true
vim.o.cursorcolumn = true
vim.o.list = true

-- encoding
-- vim.o.encofing = 'utf-8'
vim.scriptencoding = 'utf-8'

-- vim.o.ambiwidth = 'double'
-- vim.o.softtabstop = 2
-- vim.o.expandtab = true
-- vim.o.autoindent = true
-- vim.o.smartindent = true

-- vim.o.visualbell = true
-- vim.o.showmatch = true
-- vim.o.matchtime = 1

-- search
-- vim.o.incsearch = true
-- vim.o.ignorecase = true
-- vim.o.smartcase = true
-- vim.o.hlsearch = true
-- vim.api.nvim_set_keymap('n', '<Esc><Esc>', ':nohl<CR>', { noremap = true, silent = true})

-- manipulation
vim.opt.clipboard:append{'unnamedplus'}
-- vim.g.mapleader = ' '
-- vim.o.ttimeout = true
-- vim.o.ttimeoutlen = 50

-- vim.o.undofile = true
-- vim.o.undodir = vim.fn.stdpath('cache') .. '/undo'

-- vim.api.nvim_set_keymap('n', 'j', 'gj', { noremap = true })
-- vim.api.nvim_set_keymap('n', 'k', 'gk', { noremap = true })
-- vim.api.nvim_set_keymap('n', '<Down>', 'gj', { noremap = true })
-- vim.api.nvim_set_keymap('n', '<Up>', 'gk', { noremap = true })
-- vim.api.nvim_set_keymap('n', 'gj', 'j', { noremap = true })
-- vim.api.nvim_set_keymap('n', 'gk', 'k', { noremap = true })

-- optionally enable 24-bit colour
vim.opt.termguicolors = true

-- LSP log level (ログ肥大化対策)
vim.lsp.set_log_level("ERROR")

-- require
require('autocmds')
require('lazy_nvim')
-- require('plugins')
-- require('lazy').setup(plugins)

-- disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- optionally enable 24-bit colour
vim.opt.termguicolors = true

-- nvim-tree
-- vim.cmd[[NvimTreeOpen]]
vim.keymap.set('n', '<C-n>', ':NvimTreeToggle<CR>')
vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>")

-- telescope.nvim
vim.keymap.set('n', '<leader>ff', ':Telescope find_files<CR>')
vim.keymap.set('n', '<leader>fg', ':Telescope live_grep<CR>')

-- img-paste.vim
vim.keymap.set('n', '<leader>p', ':call mdip#MarkdownClipboardImage()<CR>')
vim.g.mdip_imgdir = '../../static/img'
vim.g.mdip_imgdir_intext = '/img'
vim.g.mdip_imgname = 'image'


-- Set filetype to toml for common AWS config files
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
    pattern = {
        "*/.aws/config",
        "*/.aws/credentials",
        "*.awsconfig",
        "*.awscredentials"
    },
    command = "set filetype=toml",
})

