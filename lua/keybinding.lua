-- Separate keybinding.lua from config.lua because other configs need to call it and get its return value.
--
--vim.opt if for things you would set in vimscript. vim.g is for things you"d let.
vim.opt.timeoutlen = 1000 -- shortcut key combination timeout in milliseconds
vim.g.mapleader = ";" -- Usually make, cmake and debug commands should be triggered with the leader key.

-- Keybindings (including plugin keybindings) local map = vim.api.nvim_set_keymap
local m = { noremap = true, silent = true }
local plugin_keys = {}
local map = vim.api.nvim_set_keymap
-- search (find) and format
map("n", "f", "", m) -- cancel the original function (find char *) of key f.
map("n", "fn", ":noh<CR>", m)
map("n", "ff", ":Format<CR>", m)
map("n", "fw", ":FormatWrite<CR>", m)
-- navigation
map("n", "<C-U>", "4k", m)
map("n", "<C-D>", "4j", m)
-- window split
--map("n", "<C-H>", "<C-W>h", m) -- Should be handled by tmux.nvim automatically.
--map("n", "<C-J>", "<C-W>j", m) -- Should be handled by tmux.nvim automatically.
--map("n", "<C-K>", "<C-W>k", m) -- Should be handled by tmux.nvim automatically.
--map("n", "<C-L>", "<C-W>l", m) -- Should be handled by tmux.nvim automatically.
map("n", "s", "", m) -- cancel the original function (substitute char) of key s and use it for window split.
map("n", "sv", ":vsp<CR>", m) -- vertical split
map("n", "sh", ":sp<CR>", m) -- horizontal split
map("n", "sq", "<C-w>c", m) -- close current split
map("n", "sx", "<C-w>o", m) -- close other splits except the current one
map("n", "s=", "<C-w>=", m) -- equally resize all splits
map("n", "<C-Left>", ":vertical resize -2<CR>", m)
map("n", "<C-Right>", ":vertical resize +2<CR>", m)
map("n", "<C-Down>", ":resize +2<CR>", m)
map("n", "<C-Up>", ":resize -2<CR>", m)
map("v", "ss", "y<ESC>/<C-R>\"<CR>", m) -- search selection.
map("v", "sr", "y<ESC>:%s/<C-R>\"//g<LEFT><LEFT>", m) -- search and replace in current file.
-- terminal
map("n", "t", "", m) -- cancel the original function (go until char *) of key t and use it for terminal control.
map("n", "tt", ":wincmd l | terminal<CR>", m) -- Move to the right window first in case cursor is in the nvim-tree window.
map("n", "ts", ":wincmd l | 20sp | terminal<CR>", m)
map("n", "tv", ":wincmd l | vsp | terminal<CR>", m)
map("n", "tf", ":FloatermToggle<CR>", m)
map("n", "<F1>", ":FloatermToggle<CR>", m)
--map("t", "<Esc>", "<C-\\><C-n>", m)  --To avoid conflict with LazyGit, do not use <ESC>.
map("t", "<C-Q>", "<C-\\><C-n>", m)
-- block operation in visual mode
map("v", "<", "<gv", m) -- block modify indentation
map("v", ">", ">gv", m)
map("v", "J", ":move '>+1<CR>gv-gv", m) -- move code block
map("v", "K", ":move '<-2<CR>gv-gv", m)
-- file operation
map("n", "<leader>q", ":q<CR>", m)
map("n", "<leader>qq", ":qa!<CR>", m)
--map("n", "<C-S>", ":w<CR>", m) -- Conflicts with split. Replaced by autosave.
--map("i", "<C-S>", "<ESC>:w<CR>", m)
-- nvim tree
map("n", "tr", ":NvimTreeToggle<CR>", m)
--map('n', 'trf', ':NvimTreeRefresh<CR>', m) -- Close tree and open again to refresh.
map("n", "tl", ":NvimTreeFindFile<CR>", m) -- Locate file
-- -- 's' in nvim will open file/folder in externally.
-- git
map("n", "gt", ":LazyGit<CR>", m)
map("n", "gs", ":Gitsigns toggle_signs<CR>", m)
map("n", "gl", ":Gitsigns toggle_linehl<CR>", m)
map("n", "gn", ":Gitsigns toggle_numhl<CR>", m)
map("n", "gb", ":Gitsigns toggle_current_line_blame<CR>", m)
map("n", "gw", ":Gitsigns toggle_word_diff<CR>", m)
-- telescope
map("n", "<C-F>", ":Telescope find_files<CR>", m)
map("n", "sf", ":Telescope find_files<CR>", m)
map("n", "<C-G>", ":Telescope live_grep<CR>", m)
map("n", "sg", ":Telescope live_grep<CR>", m)

-- LSP
--map("n", "g", "", m)  -- g is used to go to different places in original vim. Do not cancel.
--map("n", "gb", "<C-O>", m)  -- Conflicts with gb (git blame) from gitsigns, keep using original <C-O>.
--map("n", "gf", "<C-I>", m)

-- CMP
-- leader key region
-- Add bufferline keys as original <C-A> mapping is hard to press.
-- bufferline
map("n", "<leader>h", ":BufferLineCyclePrev<CR>", m)
map("n", "<leader>j", ":BufferLineCyclePrev<CR>", m)
map("n", "<F2>", ":BufferLineCyclePrev<CR>", m)
map("n", "<leader>x", ":Bdelete!<CR>", m)
map("n", "<F4>", ":Bdelete!<CR>", m)
map("n", "<leader>l", ":BufferLineCycleNext<CR>", m)
map("n", "<leader>k", ":BufferLineCycleNext<CR>", m)
map("n", "<F3>", ":BufferLineCycleNext<CR>", m)
-- makefile
map("n", "<leader>mk", ":make<CR><CR>", m)
map("n", "<leader>mc", ":make clean<CR><CR>", m)
map("n", "<leader>mv", ":make view<CR><CR>", m)
-- CMake
--map("n", "c", "", m)
map("n", "<leader>cf", ":CMake configure<CR>", m)
map("n", "<leader>cst", ":CMake select_target<CR>", m)
map("n", "<leader>csb", ":CMake select_build_type<CR>", m)
map("n", "<leader>cb", ":CMake build all<CR>", m)
map("n", "<leader>cr", ":CMake build_and_run<CR>", m)
map("n", "<leader>cq", ":cclose<CR>", m) -- Close build window by closing quickfix window.
map("n", "<leader>cc", ":CMake clean<CR>", m)
map("n", "<leader>cx", ":CMake cancel<CR>", m)
--map("n", "cr", ":execute "CMake clean" | execute "CMake build"<CR>", m) --Cannot use "|" directly because it will be treated as a parameter of CMake command. See :help :bar. TODO: fix "Another job is currently running" error.
--map("n", "<leader>cl", ":CMake cancel<CR>", m)
-- Projects
map("n", "<leader>pl", ":SessionManager load_session<CR>", m)
map("n", "<leader>ps", ":SessionManager save_current_session<CR>", m)
map("n", "<leader>pd", ":SessionManager delete_session<CR>", m)
-- Insertion macro
map("n", "<leader>io", "o<ESC>", m)

-- Debug
-- -- vimspector
--map("n", "<F5>", ":call vimspector#Continue()<CR>", m)
--map("n", "<F6>", ":call vimspector#RunToCursor()<CR>", m)
--map("n", "<F7>", ":call vimspector#Pause()<CR>", m)
--map("n", "<F8>", ":call vimspector#Stop()<CR>", m)
--map("n", "<F10>", ":call vimspector#StepOver()<CR>", m)
--map("n", "<F11>", ":call vimspector#StepInto()<CR>", m)
--map("n", "<F12>", ":call vimspector#StepOut()<CR>", m)
--map("n", "tb", ":call vimspector#ToggleBreakpoint()<CR>", m)
--map("n", "tbl", ":call vimspector#ListBreakpoints()<CR>", m)
--map("n", "tr", ":call vimspector#Launch()<CR>", m) -- r for run
--map("n", "tx", ":call vimspector#Reset()<CR>", m) -- x for stop
-- -- nvim-dap
map("n", "<leader>db", "<cmd>lua require('dap').toggle_breakpoint()<CR>", m)
map("n", "<leader>dc", "<cmd>lua require('dap').set_breakpoint(vim.fn.input '[Condition] > ')<CR>", m)
map("n", "<leader>de", "<cmd>lua require('dapui').eval()<CR>", m)
map("n", "<F5>", "<cmd>lua require('dap').continue()<CR>", m)
map("n", "<F8>", "<cmd>lua require('dap').terminate()<CR>", m)
map("n", "<F9>", "<cmd>lua require('dap').run_to_cursor()<CR>", m)
map("n", "<F10>", "<cmd>lua require('dap').step_over()<CR>", m)
map("n", "<F11>", "<cmd>lua require('dap').step_into()<CR>", m)
map("n", "<F12>", "<cmd>lua require('dap').step_out()<CR>", m)
map("v", "<C-E>", "<cmd>lua require('dapui').eval()<CR>", m)

return plugin_keys
