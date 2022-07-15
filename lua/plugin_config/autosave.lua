local plugin_name = 'autosave'
local ret_ok, inst = pcall(require, plugin_name)
if not ret_ok then
    vim.notify(plugin_name .. ' not found.')
    return
end

inst.setup({
    enabled = true,
    --execution_message = "AutoSave: saved at " .. vim.fn.strftime("%H:%M:%S"),
    execution_message = "",
    events = { 'InsertLeave', 'TextChanged' },
    conditions = {
        exists = true,
        filename_is_not = {},
        filetype_is_not = {},
        modifiable = true,
    },
    write_all_buffers = false,
    on_off_commands = false,
    clean_command_line_interval = 0,
    debounce_delay = 135,
})
