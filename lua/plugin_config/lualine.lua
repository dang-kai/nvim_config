local plugin_name = 'lualine'
local ret_ok, inst = pcall(require, plugin_name) 
if not ret_ok then
    vim.notify(plugin_name .. ' not found.')
    return
end

local color = {
  bg       = '#222222',
  fg       = '#BBC2CF',
  yellow   = '#ECBE7B',
  cyan     = '#008080',
  darkblue = '#081633',
  green    = '#98BE65',
  orange   = '#FF8800',
  violet   = '#A9A1E1',
  magenta  = '#C678DD',
  blue     = '#51AFEF',
  red      = '#EC5F67',
}

local custom_theme = require 'lualine.themes.tokyonight'

-- Change the background of lualine_c section for normal mode
custom_theme.normal.c.bg = 'None'

inst.setup { 
  options = {
    theme = custom_theme, 
    component_separators = { left = "|", right = "|" },
    -- https://github.com/ryanoasis/powerline-extra-symbols
    section_separators = { left = " ", right = " " },
  },
  extensions = { "nvim-tree", "toggleterm" },
  sections = {
    lualine_c = {
      "filename",
      {
        "lsp_progress",
        spinner_symbols = { " ", " ", " ", " ", " ", " " },
      },
    },
    lualine_x = {
      "filesize",
      {
        "fileformat",
        -- symbols = {
        --   unix = '', -- e712
        --   dos = '', -- e70f
        --   mac = '', -- e711
        -- },
        symbols = {
          unix = "LF",
          dos = "CRLF",
          mac = "CR",
        },
      },
      "encoding",
      "filetype",
    },
  },
}
