local m = { noremap = true, silent = true }
local map = vim.api.nvim_buf_set_keymap

-- Ekslog insert date
map(0, 'n', '<leader>id', ':EkslogInsertTimeStamp<CR>$', m)
map(0, 'n', '<leader>od', 'o<ESC>o<ESC>k<ESC>:EkslogInsertTimeStamp<CR>j<ESC>', m)

-- Ekslog popup window
map(0, 'n', 'so', ':EkslogToggleOutline<CR>', m)
map(0, 'n', 'si', ':EkslogToggleItem<CR>', m)

