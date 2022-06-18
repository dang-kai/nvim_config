-- Install packer.nvim if packer is not found
-- -- Install folder: ~/.local/share/nvim/site/pack/packer/
local fn = vim.fn
local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
local packer_bootstrap
if fn.empty(fn.glob(install_path)) > 0 then
    vim.notify('Packer not found. Installing pakcer.nvim...')
    paccker_bootstrap = fn.system({
        "git",
        "clone",
        "--depth",
        "1",
        "https://github.com/wbthomason/packer.nvim",
        -- or "https://gitcode.net/mirrors/wbthomason/packer.nvim",
        install_path,
    })

    -- https://github.com/wbthomason/packer.nvim/issues/750
    local rtp_addition = vim.fn.stdpath("data") .. "/site/pack/*/start/*"
    if not string.find(vim.o.runtimepath, rtp_addition) then
        vim.o.runtimepath = rtp_addition .. "," .. vim.o.runtimepath
    end
    vim.notify("packer.nvim installed.")
end

-- -- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
    vim.notify("Cannot find packer.nvim.")
    return
end

-- Manage plugins with packer
local packer = require('packer')
conf = {
    display = {
        open_fn = function()
            return require("packer.util").float({ border = "single" })
        end,
    },
}
packer.init(conf)
packer.startup(function()
    -- packer itself
    use { 'wbthomason/packer.nvim' }

    -- nvim-tree
    use { 'kyazdani42/nvim-tree.lua', requires = 'kyazdani42/nvim-web-devicons' }
    
    -- tab view (keep tabbed windows on the right while nvim-tree on the left)
    use { 'romgrk/barbar.nvim', requires = 'kyazdani42/nvim-web-devicons' }

    -- colorschemes
    use { 'folke/tokyonight.nvim' }
    use { "mhartington/oceanic-next" }
    use { "ellisonleao/gruvbox.nvim", requires = { "rktjmp/lush.nvim" } }
    use { "shaunsingh/nord.nvim" }
    use { "ful1e5/onedark.nvim" }
    use { "EdenEast/nightfox.nvim" }

    -- gitsigns
    --use { 'lewis6991/gitsigns.nvim' }
end)

-- Plugin configurations

-- nvim-tree
local tree_width = 26
local nvim_tree = require('nvim-tree')
nvim_tree.setup {
    disable_netrw = true,
    hijack_netrw = true,
    view = {
        adaptive_size = false,
        width = tree_width,
        side = 'left',
        number = true,
        relativenumber = true,
    },
}

local function sleep(n)
  os.execute("sleep " .. tonumber(n))
end

-- night-fox
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
require('nightfox').setup({ palettes = palettes })

-- bufferline
--vim.opt.termguicolors = true
--require("bufferline").setup {
--    options = {
--        -- Use nvim internal lsp
--        diagnostics = "nvim_lsp",
--        -- Leave left panel for nvim-tree
--        offsets = {{
--            filetype = "NvimTree",
--            text = "File Explorer",
--            highlight = "Directory",
--            text_align = "left"
--        }}
--    }
--}
--
-- Set barbar's options
require('bufferline').setup {
  -- Enable/disable animations
  animation = false,

  -- Enable/disable auto-hiding the tab bar when there is a single buffer
  auto_hide = true,

  -- Enable/disable current/total tabpages indicator (top right corner)
  tabpages = true,

  -- Enable/disable close button
  closable = true,

  -- Enables/disable clickable tabs
  --  - left-click: go to buffer
  --  - middle-click: delete buffer
  clickable = true,

  -- Excludes buffers from the tabline
  --exclude_ft = {'javascript'},
  --exclude_name = {'package.json'},

  -- Enable/disable icons
  -- if set to 'numbers', will show buffer index in the tabline
  -- if set to 'both', will show buffer index and icons in the tabline
  icons = true,

  -- If set, the icon color will follow its corresponding buffer
  -- highlight group. By default, the Buffer*Icon group is linked to the
  -- Buffer* group (see Highlighting below). Otherwise, it will take its
  -- default value as defined by devicons.
  icon_custom_colors = false,

  -- Configure icons on the bufferline.
  icon_separator_active = '▎',
  icon_separator_inactive = '▎',
  icon_close_tab = '',
  icon_close_tab_modified = '●',
  icon_pinned = '車',

  -- If true, new buffers will be inserted at the start/end of the list.
  -- Default is to insert after current buffer.
  insert_at_end = false,
  insert_at_start = false,

  -- Sets the maximum padding width with which to surround each tab
  maximum_padding = 1,

  -- Sets the maximum buffer name length.
  maximum_length = 32,

  -- If set, the letters for each buffer in buffer-pick mode will be
  -- assigned based on their name. Otherwise or in case all letters are
  -- already assigned, the behavior is to assign letters in order of
  -- usability (see order below)
  semantic_letters = true,

  -- New buffer letters are assigned in this order. This order is
  -- optimal for the qwerty keyboard layout but might need adjustement
  -- for other layouts.
  letters = 'asdfjkl;ghnmxcvbziowerutyqpASDFJKLGHNMXCVBZIOWERUTYQP',

  -- Sets the name of unnamed buffers. By default format is "[Buffer X]"
  -- where X is the buffer number. But only a static string is accepted here.
  no_name_title = nil,
}

local nvim_tree_events = require('nvim-tree.events')
local bufferline_state = require('bufferline.state')

nvim_tree_events.on_tree_open(function ()
  bufferline_state.set_offset(tree_width + 1, "File Tree")
end)

nvim_tree_events.on_tree_close(function ()
  bufferline_state.set_offset(0)
end)

-- gitsigns
--require('gitsigns').setup {
--  signs = {
--    add          = {hl = 'GitSignsAdd'   , text = '│', numhl='GitSignsAddNr'   , linehl='GitSignsAddLn'},
--    change       = {hl = 'GitSignsChange', text = '│', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn'},
--    delete       = {hl = 'GitSignsDelete', text = '_', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn'},
--    topdelete    = {hl = 'GitSignsDelete', text = '‾', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn'},
--    changedelete = {hl = 'GitSignsChange', text = '~', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn'},
--  },
--  signcolumn = true,  -- Toggle with `:Gitsigns toggle_signs`
--  numhl      = false, -- Toggle with `:Gitsigns toggle_numhl`
--  linehl     = false, -- Toggle with `:Gitsigns toggle_linehl`
--  word_diff  = false, -- Toggle with `:Gitsigns toggle_word_diff`
--  watch_gitdir = {
--    interval = 1000,
--    follow_files = true
--  },
--  attach_to_untracked = true,
--  current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
--  current_line_blame_opts = {
--    virt_text = true,
--    virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
--    delay = 1000,
--    ignore_whitespace = false,
--  },
--  current_line_blame_formatter = '<author>, <author_time:%Y-%m-%d> - <summary>',
--  sign_priority = 6,
--  update_debounce = 100,
--  status_formatter = nil, -- Use default
--  max_file_length = 40000,
--  preview_config = {
--    -- Options passed to nvim_open_win
--    border = 'single',
--    style = 'minimal',
--    relative = 'cursor',
--    row = 0,
--    col = 1
--  },
--  yadm = {
--    enable = false
--  },
--  on_attach = function(bufnr)
--    local gs = package.loaded.gitsigns
--
--    local function map(mode, l, r, opts)
--      opts = opts or {}
--      opts.buffer = bufnr
--      vim.keymap.set(mode, l, r, opts)
--    end
--
--    -- Navigation
--    map('n', ']c', function()
--      if vim.wo.diff then return ']c' end
--      vim.schedule(function() gs.next_hunk() end)
--      return '<Ignore>'
--    end, {expr=true})
--
--    map('n', '[c', function()
--      if vim.wo.diff then return '[c' end
--      vim.schedule(function() gs.prev_hunk() end)
--      return '<Ignore>'
--    end, {expr=true})
--
--    -- Actions
--    map({'n', 'v'}, '<leader>hs', ':Gitsigns stage_hunk<CR>')
--    map({'n', 'v'}, '<leader>hr', ':Gitsigns reset_hunk<CR>')
--    map('n', '<leader>hS', gs.stage_buffer)
--    map('n', '<leader>hu', gs.undo_stage_hunk)
--    map('n', '<leader>hR', gs.reset_buffer)
--    map('n', '<leader>hp', gs.preview_hunk)
--    map('n', '<leader>hb', function() gs.blame_line{full=true} end)
--    map('n', '<leader>tb', gs.toggle_current_line_blame)
--    map('n', '<leader>hd', gs.diffthis)
--    map('n', '<leader>hD', function() gs.diffthis('~') end)
--    map('n', '<leader>td', gs.toggle_deleted)
--
--    -- Text object
--    map({'o', 'x'}, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
--  end
--}

-- Key bindings
-- Initialization commands
return packer
