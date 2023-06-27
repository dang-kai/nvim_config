local plugin_name = 'nvim-treesitter.configs'
local ret_ok, inst = pcall(require, plugin_name)
if not ret_ok then
    vim.notify(plugin_name .. ' not found.')
    return
end

inst.setup({
    ensure_installed = {
        'c',
        'cpp',
        'bash',
        'cmake',
        'make',
        'bibtex',
        'latex',
        'python',
        'vim',
        'lua',
        'diff',
        'markdown',
        'json',
        'html',
        --'matlab',
    },
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
    },
    incremental_selection = {
        enable = true,
        keymaps = {
            init_selection = '<leader>fi',
            node_incremental = '<leader>fj',
            node_decremental = '<leader>fk',
            scope_incremental = '<leader>fo',
        },
    },
    indent = {
        enable = true,
        disable = { 'python' }, -- Let other plugin handle python indent.
    },
})

-- Enable folding
--vim.opt.foldmethod = 'expr'
--vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'
-- Do not fold by default
-- https://stackoverflow.com/questions/8316139/how-to-set-the-default-to-unfolded-when-you-open-a-file
--vim.opt.foldlevel = 99
