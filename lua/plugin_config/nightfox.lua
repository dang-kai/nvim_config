local plugin_name = 'nightfox'
local ret_ok, inst = pcall(require, plugin_name)
if not ret_ok then
    vim.notify(plugin_name .. ' not found.')
    return
end

local palettes = {
    -- Everything defined under `all` will be applied to each style.
    all = {
        -- Each palette defines these colors:
        --   black, red, green, yellow, blue, magenta, cyan, white, orange, pink
        --
        -- These colors have 3 shades: base, bright, and dim
        --
        -- Defining just a color defines it's base color
        --red = "#ff0000",
    },
    nightfox = {
        -- A specific style's value will be used over the `all`'s value
        --red = "#c94f6d",
    },
    dayfox = {
        -- Defining multiple shades is done by passing a table
        --blue = { base = "#4d688e", bright = "#4e75aa", dim = "#485e7d" },
    },
    nordfox = {
        -- A palette also defines the following:
        --   bg0, bg1, bg2, bg3, bg4, fg0, fg1, fg2, fg3, sel0, sel1, comment
        --
        -- These are the different foreground and background shades used by the theme.
        -- The base bg and fg is 1, 0 is normally the dark alternative. The others are
        -- incrementally lighter versions.
        --bg1 = "#2e3440",

        -- sel is different types of selection colors.
        --sel0 = "#3e4a5b", -- Popup bg, visual selection bg
        --sel1 = "#4f6074", -- Popup sel bg, search bg

        -- comment is the definition of the comment color.
        --comment = "#60728a",
        bg0 = '#262626', -- File tree background.
        bg1 = '#262626', -- Main window background.
        comment = '#A0A0A0',
        --fg1 = '#A0A0A0',
        --fg2 = '#A0A0A0',
        fg3 = '#A0A0A0', -- Color of line numbers and folds.

        white = { base = '#E0E0E0', bright = '#F0F0F0' },
        black = { base = '#262626', bright = '#585858' },
        red = { base = '#EE3344', bright = '#EF6677' },
        green = { base = '#50EB58', bright = '#C7E7A9' }, -- green = { base = '#4E9A06', bright = '#8AE234' },
        yellow = { base = '#C4A000', bright = '#EBDC50' },
        blue = { base = '#60A2F8', bright = '#6B9BED' }, -- blue = { base = '#598DF5', bright = '#91B5FE' },
        purple = { base = '#7A00D3', bright = '#BC5FD3' }, -- purple = { base = '#831EF0', bright = '#BC5FD3' },
        cyan = { base = '#09CDA6', bright = '#2DDDE9' },
        orange = { base = '#FF6600', bright = '#FF99FF' },
        pink = { base = '#FF2A7F', bright = '#FF80B2' },
        magenta = { base = '#C837AB', bright = '#D35FBC' },
    },
}

local options = {
    inverse = {
        match_paren = false,
        visual = false,
        search = false,
    },
}

local specs = {
    nordfox = {
        syntax = {
            field = 'blue.bright',
            func = 'cyan.bright',
            variable = 'yellow.bright',
        },
    },
}

inst.setup({
    palettes = palettes,
    options = options,
    specs = specs,
})
