-- Separate keybinding.lua from config.lua because other configs need to call it and get its return value.
-- Keybindings (including plugin keybindings)
local map = vim.api.nvim_set_keymap
local m = { noremap = true, silent = true }
local plugin_keys = {}
map('n', 'f', '', m)  -- cancel the original function (find char *) of key f, make it available for further configurations.
-- -- navigation
map('n', '<C-U>', '4k', m)
map('n', '<C-D>', '4j', m)
-- -- window split
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
-- -- terminal
map('n', 't', '', m)  -- cancel the original function (go until char *) of key t and use it for terminal control.
map('n', 'tt',  ':wincmd l | terminal<CR>',  m)  -- Move to the right window first in case cursor is in the nvim-tree.
map('n', 'ts',  ':wincmd l | 20sp | terminal<CR>',  m)
map('n', 'tv',  ':wincmd l | vsp | terminal<CR>', m)
map('t', '<Esc>', '<C-\\><C-n>', m)
-- -- block operation in visual mode
map('v', '<', '<gv', m)  -- block modify indentation
map('v', '>', '>gv', m)
map('v', 'J', ":move '>+1<CR>gv-gv", m) -- move code block
map('v', 'K', ":move '<-2<CR>gv-gv", m)
-- -- file operation
map('n', '<F4>',  ':q<CR>', m)
map('n', '<C-S>', ':w<CR>', m)
map('i', '<C-S>', '<ESC>:w<CR>', m)
-- -- nvim tree
map('n', '<F2>', ':NvimTreeToggle<CR>',  m)
map('n', '<F3>', ':NvimTreeRefresh<CR>', m)
-- -- bufferline
map('n', '<C-A>', ':BufferLineCyclePrev<CR>', m)
map('n', '<C-W>', ':Bdelete!<CR>', m)
map('n', '<C-D>', ':BufferLineCycleNext<CR>', m)
-- -- telescope
map("n", "<C-F>", ":Telescope find_files<CR>", m)
map("n", "<C-G>", ":Telescope live_grep<CR>", m)
plugin_keys.telescope = {
    i = {
      ["<C-J>"] = "move_selection_next",
      ["<C-K>"] = "move_selection_previous",
      ["<C-N>"] = "cycle_history_next",
      ["<C-P>"] = "cycle_history_prev",
      --["<Down>"] = "cycle_history_next",
      --["<Up>"]   = "cycle_history_prev",
      ["<ESC>"] = "close",
      ["<C-U>"] = "preview_scrolling_up",
      ["<C-D>"] = "preview_scrolling_down",
      ["<C-H>"] = "which_key"
    },
}
-- -- LSP
--map('n', 'g', '', m)  -- g is used to go to different places in original vim. Do not cancel.
map("n", "gb", "<C-O>", m)
map("n", "gf", "<C-I>", m)
-- mapbuf is the set keymap function pointer
plugin_keys.lsp = function(mapbuf)
  -- rename
  mapbuf("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", m)
  -- code action
  mapbuf("n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", m)
  -- go xx
  mapbuf("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", m)
  mapbuf("n", "gh", "<cmd>lua vim.lsp.buf.hover()<CR>", m)
  mapbuf("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", m)
  mapbuf("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", m)
  mapbuf("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", m)
  -- diagnostic
  mapbuf("n", "gp", "<cmd>lua vim.diagnostic.open_float()<CR>", m)
  mapbuf("n", "gk", "<cmd>lua vim.diagnostic.goto_prev()<CR>", m)
  mapbuf("n", "gj", "<cmd>lua vim.diagnostic.goto_next()<CR>", m)
  mapbuf("n", "<leader>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", m)
  -- mapbuf('n', '<leader>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', m)
  -- mapbuf("n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", m)
  -- mapbuf('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', m)
  -- mapbuf('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', m)
  -- mapbuf('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', m)
  -- mapbuf('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', m)
end
return plugin_keys
