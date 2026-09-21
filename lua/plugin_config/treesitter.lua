local plugin_name = 'nvim-treesitter'
local ok, treesitter = pcall(require, plugin_name)
if not ok then
    vim.notify(plugin_name .. ' not found.')
    return
end

local languages = {
    'c',
    'cpp',
    'bash',
    'cmake',
    'make',
    'python',
    'vim',
    'lua',
    'diff',
    'markdown',
    'json',
    'latex',
    'bibtex',
}

treesitter.setup()
treesitter.install(languages)

vim.api.nvim_create_autocmd('FileType', {
    group = vim.api.nvim_create_augroup('treesitter-highlighting', { clear = true }),
    pattern = {
        'bib',
        'c',
        'cpp',
        'cmake',
        'diff',
        'json',
        'lua',
        'make',
        'markdown',
        'python',
        'sh',
        'tex',
        'vim',
    },
    callback = function()
        vim.treesitter.start()
    end,
})

-- Enable folding
vim.opt.foldmethod = 'indent'
vim.opt.foldenable = true
--vim.opt.foldmethod = 'expr'
--vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'
-- Do not fold by default
-- https://stackoverflow.com/questions/8316139/how-to-set-the-default-to-unfolded-when-you-open-a-file
vim.opt.foldlevel = 99
vim.opt.foldlevelstart = 99
