-- NeoVim basic config
local opt = vim.opt

-- -- Search
opt.showmatch  = true
opt.ignorecase = false
opt.hlsearch   = true   -- highlight search
opt.incsearch  = true   -- incrmental search

-- -- Indentation
opt.tabstop     = 4     -- tab length
opt.softtabstop = 4     -- treat multiple spaces as tabs
opt.expandtab   = true  -- converts tabs to white space
opt.shiftwidth  = 4     -- width for autoindents
opt.autoindent  = true  -- indent a new line the same amount as the line just typed
opt.smartindent = true

-- -- Display
opt.number         = true           -- add line numbers
opt.relativenumber = true           -- show relative line numbers
opt.wildmode       = longest,list   -- get bash-like tab completions
opt.ttyfast        = true           -- speed up scrolling in Vim
opt.mouse          = a              -- enable mouse click
opt.scrolloff      = 3              -- keep a few lines below or above the cursor.
--opt.cc             = 100            -- set an 100 column border for good coding style
opt.cursorline     = false          -- highlight current cursorline
opt.ruler          = false
--opt.showmode       = false          -- vim mode prompt
--opt.showtabline    = 2              -- always show tabline
opt.splitbelow     = true
opt.splitright     = true

-- -- Miscellaneous
opt.clipboard   = unnamedplus   -- using system clipboard
opt.timeoutlen = 500           -- shortcut key combination timeout in milliseconds
--opt.swapfile  = false         -- disable creating swap file
--opt.hidden    = true            -- allow hidden buffer (for multiple buffers?)

-- -- Keybindings (including plugin keybindings)
local map = vim.api.nvim_set_keymap
local m = { noremap = true, silent = true }
-- -- -- window split
map('n', '<C-H>', '<C-W>h', m)
map('n', '<C-J>', '<C-W>j', m)
map('n', '<C-K>', '<C-W>k', m)
map('n', '<C-L>', '<C-W>l', m)
map('n', 's',     ''      , m)  -- cancel the original function (substitute char) of key s and use it for window split.
map('n', 'sv', ':vsp<CR>', m) -- vertical split
map('n', 'sh', ':sp<CR>',  m) -- horizontal split
map('n', 'sc', '<C-w>c',   m) -- close current split
map('n', 'so', '<C-w>o',   m) -- close other splits except the current one
map('n', 's=', '<C-w>=',   m) -- equally resize all splits
map('n', '<C-Left>',  ':vertical resize -2<CR>', m)
map('n', '<C-Right>', ':vertical resize +2<CR>', m)
map('n', '<C-Down>',  ':resize +2<CR>', m)
map('n', '<C-Up>',    ':resize -2<CR>', m)
-- -- -- terminal
map('n', 't', '', m)  -- cancel the original function (go until char *) of key t and use it for terminal control.
map('n', 'ts',  ':sp | terminal<CR>',  m)
map('n', 'tv',  ':vsp | terminal<CR>', m)
map('t', '<Esc>', '<C-\\><C-n>', opt)
-- -- -- block operation in visual mode
map('v', '<', '<gv', m)  -- block modify indentation
map('v', '>', '>gv', m)
map('v', 'J', ":move '>+1<CR>gv-gv", m) -- move code block
map('v', 'K', ":move '<-2<CR>gv-gv", m)
-- -- -- file operation                                                    
map('n', '<F4>',  ':q<CR>', m)
map('n', '<C-S>', ':w<CR>', m)
-- -- -- nvim tree
map('n', '<F2>', ':NvimTreeToggle<CR>',  m)
map('n', '<F3>', ':NvimTreeRefresh<CR>', m)
-- -- -- barbar                
map('n', '<C-Q>', ':BufferPrevious<CR>', m)
map('n', '<C-W>', ':BufferClose<CR>',    m)
map('n', '<C-E>', ':BufferNext<CR>',     m)


