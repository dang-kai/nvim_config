-- Install lazy.nvim if lazy is not found
local fn = vim.fn
local plugin_manager_path = fn.stdpath('data') .. '/lazy/lazy.nvim'
if fn.empty(fn.glob(plugin_manager_path)) > 0 then
    vim.notify('lazy.nvim not found. Installing...')
    fn.system({
        'git',
        'clone',
        '--filter=blob:none',
        'https://github.com/folke/lazy.nvim.git',
        '--branch=stable',
        plugin_manager_path,
    })
    vim.notify('lazy.nvim installed.')
end
vim.opt.rtp:prepend(plugin_manager_path)

-- -- Use a protected call so we don't error out on first use
local status_ok, lazy = pcall(require, 'lazy')
if not status_ok then
    vim.notify('Cannot find lazy.nvim.')
    return
end

-- Manage plugins with packer
local options = {}

local plugins = {
    ----------GENERAL-------------------------------------------
    -- Colorscheme
    {
        'EdenEast/nightfox.nvim',
        lazy = false,
        priority = 1000,
        config = function()
            require('plugin_config.nightfox')
        end,
    },

    -- Plugin manager itself
    { 'folke/lazy.nvim', lazy = true },

    -- File tree
    {
        'nvim-tree/nvim-tree.lua',
        lazy = true,
        cmd = { 'NvimTreeToggle', 'NvimTreeFindFile' },
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        config = function()
            require('plugin_config.nvimtree')
        end,
    },

    -- Tab view (options: barbar, cokeline, bufferline)
    {
        'romgrk/barbar.nvim',
        lazy = true,
        event = 'BufAdd',
        tag = 'release/1.4.1',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        config = function()
            require('plugin_config.barbar')
        end,
    },

    -- Search file in workspace
    {
        'nvim-telescope/telescope.nvim',
        lazy = false,
        dependencies = { 'nvim-lua/plenary.nvim', 'nvim-telescope/telescope-ui-select.nvim' },
        config = function()
            require('plugin_config.telescope')
        end,
    }, -- TODO: lazy load on command causes error.

    -- Syslog outline
    {
        url = 'dk@aeserv1:/home/dk/453/workspace/nvim-syslog.git',
        lazy = true,
        cmd = { 'SyslogToggleOutline', 'SyslogToggleItem' },
    },

    -- Dashboard
    {
        'dang-kai/dashboard-nvim',
        enabled = false,
        tag = 'v1.0.0',
        config = function()
            require('plugin_config.dashboard')
        end,
    },

    -- Session management
    {
        'Shatur/neovim-session-manager',
        dependencies = { 'nvim-lua/plenary.nvim' },
        config = function()
            require('plugin_config.session')
        end,
    },

    -- Git support
    {
        'lewis6991/gitsigns.nvim',
        config = function()
            require('plugin_config.gitsigns')
        end,
    },
    {
        'kdheepak/lazygit.nvim',
        lazy = true,
        cmd = { 'LazyGit' },
    },

    -- To avoid opening file in unwanted windows (for example, quickfix).
    {
        'stevearc/stickybuf.nvim',
        enabled = false,
    },

    -- Auto save
    {
        'jakobkhansen/AutoSave.nvim',
        config = function()
            require('plugin_config.autosave')
        end,
    },

    -- Floating terminal
    {
        'voldikss/vim-floaterm',
        config = function()
            vim.g.floaterm_width = 0.7
            vim.g.floaterm_height = 0.7
        end,
    },

    -- Tmux integration
    {
        'aserowy/tmux.nvim',
        config = function()
            require('plugin_config.tmux')
        end,
    },

    ----------PROGRAMMING---------------------------------------
    -- Code format
    {
        'mhartington/formatter.nvim',
        lazy = true,
        cmd = { 'Format' },
        config = function()
            require('plugin_config.formatter')
        end,
    },

    -- CMake support
    { 'Shatur/neovim-cmake', enabled = true, dependencies = { 'nvim-lua/plenary.nvim', 'mfussenegger/nvim-dap' } },

    -- (VIM plugin) python indent
    { 'Vimjas/vim-python-pep8-indent', enabled = false },

    -- Treesitter
    { 'nvim-treesitter/nvim-treesitter', enabled = false, build = ':TSUpdate' },

    -- LSP (Language Server Protocol) (additional: lspsaga)
    { 'neovim/nvim-lspconfig', enabled = false },
    { 'onsails/lspkind-nvim', enabled = false, dependencies = 'neovim/nvim-lspconfig' }, -- Replace text kind description with icons

    -- Code outline (options: aerial, symbols-outline)
    { 'stevearc/aerial.nvim', enabled = false },

    -- Debug
    { 'mfussenegger/nvim-dap', enabled = false },
    { 'theHamsta/nvim-dap-virtual-text', enabled = false, dependencies = 'mfussenegger/nvim-dap' },
    { 'rcarriga/nvim-dap-ui', enabled = false, dependencies = 'mfussenegger/nvim-dap', tag = 'v2.6.0' },
    { 'nvim-telescope/telescope-dap.nvim', enabled = false, dependencies = 'mfussenegger/nvim-dap' },

    -- Auto completion
    { 'hrsh7th/nvim-cmp', enabled = false, event = 'InsertEnter', dependencies = { 'hrsh7th/cmp-path', 'hrsh7th/cmp-nvim-lsp' } },
    { 'hrsh7th/vim-vsnip', enabled = false }, -- Snippet engine
    { 'hrsh7th/cmp-vsnip', enabled = false }, -- Sninppet source: vnsnip
    --{ 'hrsh7th/cmp-nvim-lsp' }, -- Snippet source: lsp
    --{ 'hrsh7th/cmp-path' },  -- Snippet source: path
    --{ "hrsh7th/cmp-buffer" }, -- Snippet source: buffer
    --{ "hrsh7th/cmp-cmdline" }, -- Snippet source: command line
    --{ 'rafamadriz/friendly-snippets' } -- Other common snippets sources
}

lazy.setup(plugins, options)

-- Plugin configurations
----------GENERAL-------------------------------------------
----require("plugin_config.bufferline")
--require('plugin_config.cokeline')
--require("plugin_config.lualine")
----------PROGRAMMING---------------------------------------
--require('plugin_config.treesitter')
--require('plugin_config.lspconfig')
----require("plugin_config.lspkind")
----require("plugin_config.lspsaga")
--require('plugin_config.cmp')
--require('plugin_config.formatter')
----require('plugin_config.dashboard')
----require("plugin_config.project")
--require('plugin_config.cmake')
--require('plugin_config.aerial')
----require('plugin_config.symbols_outline')
----require('plugin_config.stickybuf')
--require('plugin_config.dap')
--require('plugin_config.dap_ui')
--require('plugin_config.dap_virtual_text')

--floaterm config
