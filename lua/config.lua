-- NeoVim basic config
--vim.opt if for things you would set in vimscript. vim.g is for things you'd let.
--
-- stylua: ignore start
local opt = vim.opt
-- -- Search
opt.showmatch   = true
opt.ignorecase  = false
opt.hlsearch    = true -- Highlight search
opt.incsearch   = true -- Incrmental search

-- -- Indentation
opt.tabstop     = 4    -- Tab length
opt.softtabstop = 4    -- Treat multiple spaces as tabs
opt.expandtab   = true -- Converts tabs to white space
opt.shiftwidth  = 4    -- Width for autoindents
opt.autoindent  = true -- Indent a new line the same amount as the line just typed
opt.smartindent = true

-- -- Display
opt.number         = true           -- Add line numbers
opt.relativenumber = true           -- Show relative line numbers
opt.wildmode       = 'list:longest' -- Get bash-like tab completions
opt.ttyfast        = true           -- Speed up scrolling in Vim
opt.mouse          = 'a'            -- Enable mouse click
opt.scrolloff      = 2              -- Keep a few lines below or above the cursor.
--opt.cc           = 100            -- Set an 100 column border for good coding style
opt.cursorline     = false          -- Highlight current cursorline
opt.ruler          = false
opt.showmode       = true           -- Vim mode prompt
--opt.showtabline    = 0            -- (Tab is replaced by bufferline) always show tabline
opt.splitbelow     = true
opt.splitright     = true
opt.laststatus     = 2
opt.statusline     = '<%n> %f %y%=%c-%l:%L [%p%%]'
--opt.termguicolors  = true           -- Required by cokeline.

-- -- Miscellaneous
opt.clipboard      = 'unnamedplus' -- Using system clipboard
--opt.swapfile     = false         -- Disable creating swap file
--opt.hidden       = true          -- Allow hidden buffer (for multiple buffers?)
-- stylua: ignore end

-- -- Filetype
vim.g.do_filetype_lua = 1
vim.filetype.add({
    extension = {
        log = 'log',
    },
    --    filename = {
    --        [".foorc"] = "foorc",
    --    },
    --    pattern = {
    --        [".*/etc/foo/.*%.conf"] = "foorc",
    --    },
})
