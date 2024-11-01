-- Separate keybinding.lua from config.lua because other configs need to call it and get its return value.
--
--vim.opt if for things you would set in vimscript. vim.g is for things you would let.
vim.opt.timeoutlen = 1000 -- shortcut key combination timeout in milliseconds
vim.g.mapleader = ';' -- Usually make, cmake and debug commands should be triggered with the leader key.

-- Keybindings (including plugin keybindings) local map = vim.api.nvim_set_keymap
local m = { noremap = true, silent = true }
local plugin_keys = {}
local map = vim.api.nvim_set_keymap

-- remap 'K' to reversed 'J'. Original 'K' causes freeze.
map('n', 'K', 'jddkkpJ', m)

-- search and format
--map('n', 'f', '', m) -- cancel the original function (find char *) of key f.
map('n', '<leader>ff', ':Format<CR>', m)
--map('n', 'fw', ':FormatWrite<CR>', m)
map('v', 'ss', 'y<ESC>/<C-R>"<CR>', m) -- search selection.
map('v', 'sr', 'y<ESC>:%s/<C-R>"//g<LEFT><LEFT>', m) -- search and replace in current file.
map('n', 'sn', ':noh<CR>', m)

-- navigation
map('n', '<C-U>', '4k', m)
map('n', '<C-D>', '4j', m)

-- buffer navigation
map('n', '<F2>', ':bp<CR>', m)
map('n', '<F3>', ':bn<CR>', m)
map('n', '<F4>', ':bd<CR>', m)

-- window split
map('n', 's', '', m) -- cancel the original function (substitute char) of key s and use it for window split.
map('n', 'sv', ':vsp<CR>', m) -- vertical split
map('n', 'sh', ':sp<CR>', m) -- horizontal split
map('n', 'sq', '<C-w>c', m) -- close current split
map('n', 'sx', '<C-w>o', m) -- close other splits except the current one
map('n', 's=', '<C-w>=', m) -- equally resize all splits
map('n', 'sr', '<C-w>r', m) -- rotate split windows
map('n', '<C-Left>', ':vertical resize -2<CR>', m)
map('n', '<C-Right>', ':vertical resize +2<CR>', m)
map('n', '<C-Down>', ':resize +2<CR>', m)
map('n', '<C-Up>', ':resize -2<CR>', m)

-- terminal
map('n', 't', '', m) -- cancel the original function (go until char *) of key t and use it for terminal control.
map('n', 'tt', ':wincmd l | terminal<CR>', m) -- Move to the right window first in case cursor is in the nvim-tree window.
map('n', 'ts', ':wincmd l | 20sp | terminal<CR>', m)
map('n', 'tv', ':wincmd l | vsp | terminal<CR>', m)
map('n', 'tf', ':FloatermToggle<CR>', m)
map('n', '<F1>', ':FloatermToggle<CR>', m)
map('i', '<F1>', '', m) -- cancel the original function of <F1>.
--map('i', '<F1>', '<ESC>:FloatermToggle<CR>', m) -- Compatibility issue with telescope.
--map("t", "<Esc>", "<C-\\><C-n>", m)  --To avoid conflict with LazyGit, do not use <ESC>.
map('t', '<C-Q>', '<C-\\><C-n>', m)

-- block operation in visual mode
map('v', '<', '<gv', m) -- block modify indentation
map('v', '>', '>gv', m)
map('v', 'J', ":move '>+1<CR>gv-gv", m) -- move code block
map('v', 'K', ":move '<-2<CR>gv-gv", m)

-- file operation
--map("n", "<leader>q", ":q<CR>", m)
map('n', '<leader>qq', ':qa!<CR>', m)
--map("n", "<C-S>", ":w<CR>", m) -- Conflicts with split. Replaced by autosave.
--map("i", "<C-S>", "<ESC>:w<CR>", m)

-- nvim tree
map('n', 'tr', ':NvimTreeToggle<CR>', m)
--map('n', 'trf', ':NvimTreeRefresh<CR>', m) -- Close tree and open again to refresh.
map('n', 'tl', ':NvimTreeFindFile<CR>', m) -- Locate file
-- -- 's' in nvim will open file/folder in externally.

-- git
map('n', 'gt', ':LazyGit<CR>', m)
map('n', 'gss', ':Gitsigns toggle_signs<CR>', m)
map('n', 'gsl', ':Gitsigns toggle_linehl<CR>', m)
map('n', 'gsn', ':Gitsigns toggle_numhl<CR>', m)
map('n', 'gsb', ':Gitsigns toggle_current_line_blame<CR>', m)
map('n', 'gsw', ':Gitsigns toggle_word_diff<CR>', m)

-- telescope (and buffer management)
--map('n', '<C-F>', ':Telescope find_files<CR>', m)
map('n', 'sf', ':Telescope find_files<CR>', m) -- search file
map('n', 'ss', ':Telescope buffers<CR>', m) -- search open
map('n', 'sp', ':Telescope help_tags<CR>', m)
map('n', 'sd', ':bd<CR>', m)
--map('n', '<C-G>', ':Telescope live_grep<CR>', m)
map('n', 'sg', ':Telescope live_grep<CR>', m)
map('v', 'sg', 'y<ESC>:Telescope live_grep default_text=<C-R>0<CR>', m)

-- outline
map('n', 'to', ':AerialToggle<CR>', m)
--map('n', 'to', ':SymbolsOutline<CR>', m)

-- makefile
map('n', '<leader>mk', ':make<CR><CR>', m)
map('n', '<leader>mc', ':make clean<CR><CR>', m)
map('n', '<leader>mv', ':make view<CR><CR>', m)

-- CMake
--map("n", "c", "", m)
map('n', '<leader>cq', ':cclose<CR>', m) -- Close build window by closing quickfix window.
map('n', '<leader>cf', ':CMake configure<CR>', m)
map('n', '<leader>cst', ':CMake select_target<CR>', m)
map('n', '<leader>csb', ':CMake select_build_type<CR>', m)
map('n', '<leader>cb', ':CMake build all<CR>', m)
map('n', '<leader>cr', ':CMake build_and_run<CR>', m)
map('n', '<leader>cc', ':CMake clean<CR>', m)
map('n', '<leader>cx', ':CMake cancel<CR>', m)
--map("n", "cr", ":execute "CMake clean" | execute "CMake build"<CR>", m) --Cannot use "|" directly because it will be treated as a parameter of CMake command. See :help :bar. TODO: fix "Another job is currently running" error.
--map("n", "<leader>cl", ":CMake cancel<CR>", m)

-- Projects
map('n', '<leader>pl', ':SessionManager load_session<CR>', m)
map('n', '<leader>ps', ':SessionManager save_current_session<CR>', m)
map('n', '<leader>pd', ':SessionManager delete_session<CR>', m)

-- Insertion macro
map('n', '<leader>io', 'o<ESC>', m)

-- CSV 
map('n', '<leader>ca', ':RainbowAlign<CR>', m)
map('n', '<leader>cz', ':RainbowShrink<CR>', m)

-- Lazy.nvim
map('n', '<leader>pp', ':Lazy home<CR>', m)

-- LSP
map('n', '<leader>li', ':LspStart<CR>', m)
map('n', '<leader>lo', ':LspStop<CR>', m)

return plugin_keys
