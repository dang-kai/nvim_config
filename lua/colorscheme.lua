local colorscheme = 'nordfox'
local ret_ok, _ = pcall(vim.cmd, 'colorscheme ' .. colorscheme)
if not ret_ok then
    vim.notify('Colorscheme ' .. colorscheme .. ' not found!')
    return
end
