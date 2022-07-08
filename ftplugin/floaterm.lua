local m = { noremap = true, silent = true }
local map = vim.api.nvim_buf_set_keymap

--map("t", "<F4>", "<C-\\><C-N>", m)
map(0, "t", "<F1>", "<C-\\><C-N> :FloatermHide<CR>", m)
map(0, "t", "<F2>", "<C-\\><C-N> :FloatermPrev<CR>", m)
map(0, "t", "<F3>", "<C-\\><C-N> :FloatermNext<CR>", m)
map(0, "t", "<F4>", "<C-\\><C-N> :FloatermKill<CR>", m)
map(0, "t", "<C-T>", "<C-\\><C-N> :FloatermNew<CR>", m)
map(0, "t", "<C-X>", "<C-\\><C-N> :FloatermKill<CR>", m)
map(0, "t", "<C-Q>", "<C-\\><C-N>", m)
