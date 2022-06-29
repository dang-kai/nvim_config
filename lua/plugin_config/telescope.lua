local plugin_name = "telescope"
local ret_ok, inst = pcall(require, plugin_name)
if not ret_ok then
    vim.notify(plugin_name .. " not found.")
    return
end

inst.setup({
    defaults = {
        initial_mode = "insert",
        mappings = require("keybinding").telescope,
    },
    pickers = {
        find_files = {
            -- theme = "dropdown" | "cursor" | "ivy",
        },
    },
    extensions = {
        ["ui-select"] = {
            require("telescope.themes").get_dropdown({}),
        },
    },
})

inst.load_extension("ui-select")
