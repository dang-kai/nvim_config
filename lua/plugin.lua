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
        enabled = true,
        lazy = false,
        priority = 1000,
        config = function()
            require('plugin_config.nightfox')
            vim.cmd('colorscheme nordfox')
            vim.api.nvim_set_hl(0, 'StatusLine', { fg = '#e0e0e0' })
            vim.api.nvim_set_hl(0, '@parameter', { fg = '#09cda6' })
            vim.api.nvim_set_hl(0, '@type.builtin', { fg = '#c4a000' })
        end,
    },

    -- Plugin manager itself
    {
        'folke/lazy.nvim',
        enabled = true,
        lazy = false,
        tag = 'stable',
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
    },

    -- Syslog outline
    {
        url = 'dk@aeserv1:/home/dk/efs/repo/workspace/nvim-ekslog.git',
        enabled = true,
        lazy = true,
        cmd = { 'EkslogToggleOutline', 'EkslogToggleItem' },
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
        lazy = true,
        event = 'VeryLazy',
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
        enabled = true,
        lazy = true,
        event = 'VeryLazy',
        config = function()
            require('plugin_config.stickybuf')
        end,
    },

    -- Auto save
    {
        'jakobkhansen/AutoSave.nvim',
        enabled = true,
        lazy = true,
        event = 'VeryLazy',
        config = function()
            require('plugin_config.autosave')
        end,
    },

    -- Floating terminal
    {
        'voldikss/vim-floaterm',
        enabled = true,
        lazy = true,
        event = 'VeryLazy',
        config = function()
            vim.g.floaterm_width = 0.9
            vim.g.floaterm_height = 0.9
        end,
    },

    -- Tmux integration
    {
        'aserowy/tmux.nvim',
        enabled = true,
        lazy = true,
        event = 'VeryLazy',
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
        cmd = { 'CMake' },
        dependencies = { 'nvim-lua/plenary.nvim', 'mfussenegger/nvim-dap' },
        config = function()
            require('plugin_config.cmake')
        end,
    },

    -- (VIM plugin) python indent
    {
        'Vimjas/vim-python-pep8-indent',
        enabled = true,
        lazy = true,
        ft = 'python',
        event = 'VeryLazy',
    },

    -- Treesitter
    {
        'nvim-treesitter/nvim-treesitter',
        enabled = true,
        lazy = true,
        event = 'VeryLazy',
        build = ':TSUpdate',
        dependencies = { 'nvim-treesitter/playground' },
        config = function()
            require('plugin_config.treesitter')
        end,
    },

    -- LSP (Language Server Protocol) (additional: lspsaga)
    {
        'neovim/nvim-lspconfig',
        enabled = true,
        lazy = true,
        event = 'VimEnter',
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
        lazy = true,
        --event = 'VeryLazy',
        cmd = {
            'DAPToggleBreakPoint',
            'DAPSetConditionalBreakPoint',
            'DAPEval',
            'DAPContinue',
        },
        dependencies = {
            {
                'theHamsta/nvim-dap-virtual-text',
                config = function()
                    require('plugin_config.dap_virtual_text')
                end,
            },
            {
                'rcarriga/nvim-dap-ui',
                config = function()
                    require('plugin_config.dap_ui')
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
    ui = { border = 'single' },
}

lazy.setup(plugins, options)
