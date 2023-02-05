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

-- Manage plugins with lazy.nvim
local plugins = {
    ----------GENERAL-------------------------------------------
    -- Colorscheme
    {
        'EdenEast/nightfox.nvim',
        --'folke/tokyonight.nvim',
        enabled = true,
        lazy = false,
        priority = 1000,
        config = function()
            require('plugin_config.nightfox')
            vim.cmd('colorscheme nordfox')
            --vim.cmd('colorscheme tokyonight')
            vim.api.nvim_set_hl(0, 'BufferCurrent', { fg = '#dfdfdf', bg = '#606060' })
            vim.api.nvim_set_hl(0, 'BufferCurrentMod', { fg = '#f4d000', bg = '#606060' })
            vim.api.nvim_set_hl(0, 'BufferInactiveMod', { fg = '#c4a000', bg = '#262626' })
            vim.api.nvim_set_hl(0, 'BufferCurrentSign', { fg = '#60a2f8', bg = '#606060' })
            vim.api.nvim_set_hl(0, 'BufferInactiveSign', { fg = '#808080', bg = '#262626' })
        end,
    },

    -- Plugin manager itself
    {
        'folke/lazy.nvim',
        enabled = true,
        lazy = false,
    },

    -- File tree
    {
        'nvim-tree/nvim-tree.lua',
        enabled = true,
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
        enabled = true,
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
        enabled = true,
        lazy = true,
        cmd = { 'Telescope' },
        dependencies = { 'nvim-lua/plenary.nvim', 'nvim-telescope/telescope-ui-select.nvim' },
        config = function()
            require('plugin_config.telescope')
        end,
    }, -- TODO: lazy load on command causes error.

    -- Syslog outline
    {
        url = 'dk@aeserv1:/home/dk/453/workspace/nvim-syslog.git',
        enabled = true,
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
        enabled = true,
        dependencies = { 'nvim-lua/plenary.nvim' },
        config = function()
            require('plugin_config.session')
        end,
    },

    -- Git support
    {
        'lewis6991/gitsigns.nvim',
        enabled = true,
        config = function()
            require('plugin_config.gitsigns')
        end,
    },
    {
        'kdheepak/lazygit.nvim',
        enabled = true,
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
        enabled = true,
        config = function()
            require('plugin_config.autosave')
        end,
    },

    -- Floating terminal
    {
        'voldikss/vim-floaterm',
        enabled = true,
        config = function()
            vim.g.floaterm_width = 0.7
            vim.g.floaterm_height = 0.7
        end,
    },

    -- Tmux integration
    {
        'aserowy/tmux.nvim',
        enabled = true,
        config = function()
            require('plugin_config.tmux')
        end,
    },

    ----------PROGRAMMING---------------------------------------
    -- Code format
    {
        'mhartington/formatter.nvim',
        enabled = true,
        lazy = true,
        cmd = { 'Format' },
        config = function()
            require('plugin_config.formatter')
        end,
    },

    -- CMake support
    {
        'Shatur/neovim-cmake',
        enabled = true,
        lazy = true,
        dependencies = { 'nvim-lua/plenary.nvim', 'mfussenegger/nvim-dap' },
        cmd = { 'CMake' },
        config = function()
            require('plugin_config.cmake')
        end,
    },

    -- (VIM plugin) python indent
    {
        'Vimjas/vim-python-pep8-indent',
        enabled = true,
    },

    -- Treesitter
    {
        'nvim-treesitter/nvim-treesitter',
        enabled = false,
        build = ':TSUpdate',
        config = function()
            require('plugin_config.treesitter')
        end,
    },

    -- LSP (Language Server Protocol) (additional: lspsaga)
    {
        'neovim/nvim-lspconfig',
        enabled = true,
        dependencies = 'onsails/lspkind-nvim',
        config = function()
            require('plugin_config.lspconfig')
        end,
    },

    -- Code outline (options: aerial, symbols-outline)
    {
        'stevearc/aerial.nvim',
        enabled = true,
        lazy = true,
        cmd = { 'AerialToggle' },
        config = function()
            require('plugin_config.aerial')
        end,
    },

    -- Debug
    {
        'mfussenegger/nvim-dap',
        enabled = true,
        dependencies = {
            {
                'theHamsta/nvim-dap-virtual-text',
                config = function()
                    require('plugin_config.dap_virtual_text')
                end,
            },
            {
                'rcarriga/nvim-dap-ui',
                tag = 'v2.6.0',
                config = function()
                    require('plugin_config.dap')
                end,
            },
            'nvim-telescope/telescope-dap.nvim',
        },
        config = function()
            require('plugin_config.dap')
        end,
    },

    -- Auto completion
    {
        'hrsh7th/nvim-cmp',
        enabled = true,
        lazy = true,
        event = 'InsertEnter',
        dependencies = {
            'hrsh7th/cmp-vsnip',
            'hrsh7th/cmp-path',
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/vim-vsnip',
            --'rafamadriz/friendly-snippets'
        },
        config = function()
            require('plugin_config.cmp')
        end,
    },
}

local options = {
    ui = { border = 'rounded' },
}

lazy.setup(plugins, options)
