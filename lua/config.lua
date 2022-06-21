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
opt.wildmode       = 'list:longest' -- get bash-like tab completions
opt.ttyfast        = true           -- speed up scrolling in Vim
opt.mouse          = 'a'            -- enable mouse click
opt.scrolloff      = 3              -- keep a few lines below or above the cursor.
--opt.cc             = 100            -- set an 100 column border for good coding style
opt.cursorline     = false          -- highlight current cursorline
opt.ruler          = false
opt.showmode       = true           -- vim mode prompt
--opt.showtabline    = 0            -- (Tab is replaced by bufferline) always show tabline
opt.splitbelow     = true
opt.splitright     = true
opt.laststatus     = 0

-- -- Miscellaneous
opt.clipboard   = unnamedplus   -- using system clipboard
opt.timeoutlen  = 500           -- shortcut key combination timeout in milliseconds
--opt.swapfile  = false         -- disable creating swap file
--opt.hidden    = true            -- allow hidden buffer (for multiple buffers?)
