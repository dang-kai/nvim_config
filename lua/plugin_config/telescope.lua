local plugin_name = 'telescope'
local ret_ok, inst = pcall(require, plugin_name)
if not ret_ok then
    vim.notify(plugin_name .. ' not found.')
    return
end

inst.setup({
    defaults = {
        file_ignore_patterns = { 'wav', 'pdf' },
        initial_mode = 'insert',
        mappings = {
            i = {
                ['<C-J>'] = 'move_selection_next',
                ['<C-K>'] = 'move_selection_previous',
                ['<C-N>'] = 'cycle_history_next',
                ['<C-P>'] = 'cycle_history_prev',
                --["<Down>"] = "cycle_history_next",
                --["<Up>"]   = "cycle_history_prev",
                ['<ESC>'] = 'close',
                ['<C-U>'] = 'preview_scrolling_up',
                ['<C-D>'] = 'preview_scrolling_down',
                ['<C-X>'] = 'close',
                --['<C-S>'] = 'select_horizontal',
                --["<C-H>"] = "which_key",
                ['<C-H>'] = 'select_horizontal',
            },
        },
    },
})

inst.load_extension('ui-select')
