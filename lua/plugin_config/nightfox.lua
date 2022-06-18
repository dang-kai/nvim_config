local plugin_name = 'nightfox'
local ret_ok, inst= pcall(require, plugin_name) 
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
    bg0 = 'NONE',
    bg1 = 'NONE',

    red     = '#CC0000',
    green   = '#4E9A06',
    yellow  = '#C4A000',
    blue    = { base = '#3771C8', bright = '#5F8DD3', },
    purple  = { base = '#AB37C8', bright = '#BC5FD3', },
    cyan    = '#06989A',
    orange  = { base = '#FF6600', bright = '#FF99FF', },
    pink    = { base = '#FF2A7F', bright = '#FF80B2', },
    magenta = { base = '#C837AB', bright = '#D35FBC', },
  },
}
inst.setup({ palettes = palettes })
