local colorscheme = 'nordfox'
local ret_ok, _ = pcall(vim.cmd, 'colorscheme ' .. colorscheme)
if not ret_ok then
    vim.notify('Colorscheme ' .. colorscheme .. ' not found!')
    return
end

-- Manual color fine tunings here.
--barbar colorscheme config
--vim.cmd('highlight BufferCurrent guibg=#606060')
vim.api.nvim_set_hl(0, 'BufferCurrent', { fg = '#dfdfdf', bg = '#606060' })
vim.api.nvim_set_hl(0, 'BufferCurrentMod', { fg = '#f4d000', bg = '#606060' })
vim.api.nvim_set_hl(0, 'BufferInactiveMod', { fg = '#c4a000', bg = '#262626' })
vim.api.nvim_set_hl(0, 'BufferCurrentSign', { fg = '#60a2f8', bg = '#606060' })
vim.api.nvim_set_hl(0, 'BufferInactiveSign', { fg = '#808080', bg = '#262626' })
