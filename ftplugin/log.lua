local m = { noremap = true, silent = true }
local map = vim.api.nvim_buf_set_keymap

map(0, 'n', '<leader>id', ':r!date<CR>kJ$', m)
map(0, 'n', '<leader>od', ':r!date<CR>o<ESC>o<ESC>k', m)
