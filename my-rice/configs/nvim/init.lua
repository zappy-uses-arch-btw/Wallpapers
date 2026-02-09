--  ╔══════════════════════════════════════════════════════════════════╗
--  ║                        NEOVIM Config                             ║
--  ╚══════════════════════════════════════════════════════════════════╝

-- ─────────────────────────────────────────────────────────────────────
-- Options
-- ─────────────────────────────────────────────────────────────────────

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.mouse = 'a'
vim.opt.clipboard = 'unnamedplus'      -- System clipboard
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = true
vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.smartindent = true
vim.opt.wrap = false
vim.opt.cursorline = true
vim.opt.termguicolors = true
vim.opt.signcolumn = 'yes'
vim.opt.updatetime = 300
vim.opt.scrolloff = 8
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.swapfile = false
vim.opt.undofile = true

-- ─────────────────────────────────────────────────────────────────────
-- Leader Key
-- ─────────────────────────────────────────────────────────────────────

vim.g.mapleader = ' '

-- ─────────────────────────────────────────────────────────────────────
-- Keymaps
-- ─────────────────────────────────────────────────────────────────────

local k = vim.keymap.set
local o = { noremap = true, silent = true }

-- Window navigation
k('n', '<C-h>', '<C-w>h', o)
k('n', '<C-j>', '<C-w>j', o)
k('n', '<C-k>', '<C-w>k', o)
k('n', '<C-l>', '<C-w>l', o)

-- Buffer navigation
k('n', '<Tab>', ':bnext<CR>', o)
k('n', '<S-Tab>', ':bprevious<CR>', o)
k('n', '<leader>x', ':bdelete<CR>', o)

-- Stay in visual mode when indenting
k('v', '<', '<gv', o)
k('v', '>', '>gv', o)

-- Move lines in visual mode
k('v', 'J', ":m '>+1<CR>gv=gv", o)
k('v', 'K', ":m '<-2<CR>gv=gv", o)

-- Quick actions
k('n', '<leader>h', ':nohlsearch<CR>', o)
k('n', '<leader>w', ':w<CR>', o)
k('n', '<leader>q', ':q<CR>', o)
k('n', '<leader>e', ':Explore<CR>', o)
k('n', '<leader>v', ':vsplit<CR>', o)
k('n', '<leader>s', ':split<CR>', o)
k('n', '<leader>t', ':terminal<CR>', o)

-- Escape terminal mode
k('t', '<Esc>', '<C-\\><C-n>', o)

-- ─────────────────────────────────────────────────────────────────────
-- Netrw (File Explorer)
-- ─────────────────────────────────────────────────────────────────────

vim.g.netrw_banner = 0
vim.g.netrw_liststyle = 3
vim.g.netrw_winsize = 25

-- ─────────────────────────────────────────────────────────────────────
-- Wallust Colorscheme
-- ─────────────────────────────────────────────────────────────────────

-- Load wallust colorscheme if available
local colorscheme_path = vim.fn.expand('~/.config/nvim/colors/wallust.lua')
if vim.fn.filereadable(colorscheme_path) == 1 then
    dofile(colorscheme_path)
end
