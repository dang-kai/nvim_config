local plugin_name = "dapui"
local ret_ok, inst = pcall(require, plugin_name)
if not ret_ok then
    vim.notify(plugin_name .. " not found.")
    return
end

inst.setup({
    icons = { expanded = "", collapsed = "" },
    mappings = {
        -- Use a table to apply multiple mappings
        expand = { "o", "<2-LeftMouse>", "<CR>" },
        open = "O",
        remove = "d",
        edit = "e",
        repl = "r",
        toggle = "t",
    },
    -- Expand lines larger than the window
    -- Requires >= 0.7
    expand_lines = vim.fn.has("nvim-0.7"),
    layouts = {
        {
            elements = {
                { id = "scopes", size = 0.5 },
                { id = "watches", size = 0.2 },
                { id = "stacks", size = 0.15 },
                { id = "breakpoints", size = 0.15 },
            },
            size = 0.2,
            position = "left",
        },
        {
            elements = {
                { id = "repl", size = 0.7 },
                { id = "console", size = 0.3 },
            },
            size = 0.2,
            position = "right",
        },
    },
    floating = {
        max_height = nil, -- These can be integers or a float between 0 and 1.
        max_width = nil, -- Floats will be treated as percentage of your screen.
        border = "single", -- Border style. Can be "single", "double" or "rounded"
        mappings = {
            close = { "q", "<Esc>" },
        },
    },
    windows = { indent = 1 },
})
