local plugin_name = 'bufferline'
local ret_ok, inst = pcall(require, plugin_name)
if not ret_ok then
    vim.notify(plugin_name .. ' not found.')
    return
end

inst.setup({
    animation = false, -- Enable/disable animations
    auto_hide = true, -- Enable/disable auto-hiding the tab bar when there is a single buffer
    closable = false, -- Enable/disable close button
    clickable = true, -- Enables/disable clickable tabs - left-click: go to buffer - middle-click: delete buffer
    icons = true, -- Enable/disable icons. Other options: 'numbers', 'both'.
    icon_custom_colors = false, -- If set, the icon color will follow its corresponding buffer highlight group.
    maximum_padding = 0, -- Sets the maximum padding width with which to surround each tab
    maximum_length = 30, -- Sets the maximum buffer name length.
    tabpages = true, -- Enable/disable current/total tabpages indicator (top right corner)

    exclude_ft = { 'qf', 'dap-repl' }, -- Excludes buffers from the tabline exclude_name = { "package.json" },

    -- Configure icons on the bufferline.
    icon_separator_active = '▎',
    icon_separator_inactive = '▎',
    icon_close_tab = '',
    icon_close_tab_modified = '●',
    icon_pinned = '車',

    -- If true, new buffers will be inserted at the start/end of the list.
    -- Default is to insert after current buffer.
    --insert_at_start = false,
    --insert_at_end = false,

    -- If set, the letters for each buffer in buffer-pick mode will be
    -- assigned based on their name. Otherwise or in case all letters are
    -- already assigned, the behavior is to assign letters in order of
    -- usability (see order below)
    --semantic_letters = true,

    -- New buffer letters are assigned in this order. This order is
    -- optimal for the qwerty keyboard layout but might need adjustement
    -- for other layouts.
    --letters = 'asdfjkl;ghnmxcvbziowerutyqpASDFJKLGHNMXCVBZIOWERUTYQP',

    -- Sets the name of unnamed buffers. By default format is "[Buffer X]"
    -- where X is the buffer number. But only a static string is accepted here.
    --no_name_title = nil,
})


--local nvim_tree_events = require("nvim-tree.events")
--local bufferline_api = require("bufferline.api")
--local function get_tree_size() return require("nvim-tree.view").View.width end
--nvim_tree_events.subscribe("TreeOpen", function() bufferline_api.set_offset(get_tree_size()) end)
--nvim_tree_events.subscribe("Resize", function() bufferline_api.set_offset(get_tree_size()) end)
--nvim_tree_events.subscribe("TreeClose", function() bufferline_api.set_offset(0) end)
