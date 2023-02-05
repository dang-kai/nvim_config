local colorscheme = 'nordfox'
local ret_ok, _ = pcall(vim.cmd, 'colorscheme ' .. colorscheme)
if not ret_ok then
    vim.notify('Colorscheme ' .. colorscheme .. ' not found!')
    return
end

-- Manual color fine tunings here.
--barbar colorscheme config
--vim.cmd('highlight BufferCurrent guibg=#606060')
