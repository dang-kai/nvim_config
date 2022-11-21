local plugin_name = 'cokeline'
local ret_ok, inst = pcall(require, plugin_name)
if not ret_ok then
    vim.notify(plugin_name .. ' not found.')
    return
end

local function focused_fg(buffer)
    return buffer.is_modified and '#F2B13F' or nil
end

local function focused_bg(buffer)
    return buffer.is_focused and '#505050' or nil
end

local tab_length_min = 6
local tab_length_max = 26

inst.setup({
    -- Only show the bufferline when there are at least this many visible buffers.
    -- default: `1`.
    show_if_buffers_are_at_least = 2,

    buffers = {
        -- A function to filter out unwanted buffers. Takes a buffer table as a
        -- parameter (see the following section for more infos) and has to return
        -- either `true` or `false`.
        -- default: `false`.
        filter_valid = function(buffer)
            local ft = { 'terminal', 'qf', 'dap-repl' }
            for _, j in ipairs(ft) do
                if buffer.type == j then
                    vim.notify('buffer ' .. j .. ' ignored.')
                    return false
                end
            end
            return true
        end,

        -- A looser version of `filter_valid`, use this function if you still
        -- want the `cokeline-{switch,focus}-{prev,next}` mappings to work for
        -- these buffers without displaying them in your bufferline.
        -- default: `false`.
        filter_visible = function(_)
            return true
        end,

        -- Which buffer to focus when a buffer is deleted, `prev` focuses the
        -- buffer to the left of the deleted one while `next` focuses the one the
        -- right. Turned off by default.
        -- default: `false`
        focus_on_delete = 'prev',

        -- If set to `last` new buffers are added to the end of the bufferline,
        -- if `next` they are added next to the current buffer.
        -- default: 'last',
        new_buffers_position = 'next',
    },

    mappings = {
        -- Controls what happens when the first (last) buffer is focused and you
        -- try to focus/switch the previous (next) buffer. If `true` the last
        -- (first) buffers gets focused/switched, if `false` nothing happens.
        -- default: `true`.
        cycle_prev_next = true, -- | false,
    },

    rendering = {
        -- The maximum number of characters a rendered buffer is allowed to take
        -- up. The buffer will be truncated if its width is bigger than this
        -- value.
        -- default: `999`.
        max_buffer_width = tab_length_max,
    },

    -- The default highlight group values.
    -- The `fg` and `bg` keys are either colors in hexadecimal format or
    -- functions taking a `buffer` parameter and returning a color in
    -- hexadecimal format. Similarly, the `style` key is either a string
    -- containing a comma separated list of items in `:h attr-list` or a
    -- function returning one.
    default_hl = {
        -- default: `ColorColumn`'s background color for focused buffers,
        -- `Normal`'s foreground color for unfocused ones.
        fg = '#C8C8C8', --| function(buffer) -> '#rrggbb',

        -- default: `Normal`'s foreground color for focused buffers,
        -- `ColorColumn`'s background color for unfocused ones.
        -- default: `Normal`'s foreground color.
        bg = '#262626', --| function(buffer) -> '#rrggbb',

        -- default: `'NONE'`.
        --style = 'attr1,attr2,...' | function(buffer) -> 'attr1,attr2,...',
    },

    -- A list of components to be rendered for each buffer. Check out the section
    -- below explaining what this value can be set to.
    -- default: see `/lua/cokeline/defaults.lua`
    components = {
        -- Separator
        {
            text = function(buffer)
                return buffer.index ~= 1 and '▎' or ' '
            end,
            fg = focused_fg,
            bg = focused_bg,
            truncation = { priority = 1 },
        },
        -- Icon
        {
            text = function(buffer)
                return buffer.devicon.icon
            end,
            fg = function(buffer)
                return buffer.devicon.color
            end,
            bg = focused_bg,
            truncation = { priority = 1 },
            --delete_buffer_on_left_click = true,
        },
        -- Filename
        {
            text = function(buffer)
                local filename = buffer.filename
                if #filename < tab_length_min - 4 then
                    filename = filename .. string.rep(' ', tab_length_min - 4 - #filename)
                end
                return filename .. ' '
            end,
            fg = focused_fg,
            bg = focused_bg,
            style = function(buffer)
                return buffer.is_focused and 'bold' or nil
            end,
        },
    },

    -- Left sidebar to integrate nicely with file explorer plugins.
    -- This is a table containing a `filetype` key and a list of `components` to
    -- be rendered in the sidebar.
    -- The last component will be automatically space padded if necessary
    -- to ensure the sidebar and the window below it have the same width.
    sidebar = {
        filetype = 'NvimTree',
        components = { {
            text = 'File Tree',
            style = 'bold',
        } },
    },
})
