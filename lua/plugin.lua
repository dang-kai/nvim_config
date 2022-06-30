-- Install packer.nvim if packer is not found
-- -- Install folder: ~/.local/share/nvim/site/pack/packer/
local fn = vim.fn
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
local packer_bootstrap
if fn.empty(fn.glob(install_path)) > 0 then
    vim.notify("Packer not found. Installing pakcer.nvim...")
    packer_bootstrap = fn.system({
        "git",
        "clone",
        "--depth",
        "1",
        "https://github.com/wbthomason/packer.nvim",
        -- or "https://gitcode.net/mirrors/wbthomason/packer.nvim", install_path,
    })

    -- https://github.com/wbthomason/packer.nvim/issues/750
    local rtp_addition = vim.fn.stdpath("data") .. "/site/pack/*/start/*"
    if not string.find(vim.o.runtimepath, rtp_addition) then
        vim.o.runtimepath = rtp_addition .. "," .. vim.o.runtimepath
    end
    vim.notify("packer.nvim installed.")
end

-- -- Use a protected call so we don"t error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
    vim.notify("Cannot find packer.nvim.")
    return
end

-- Manage plugins with packer
local conf = {
    display = {
        open_fn = function()
            return require("packer.util").float({ border = "single" })
        end,
    },
}
packer.init(conf)
packer.startup(function()
    -- Packer itself
    use({ "wbthomason/packer.nvim" })

    -- Nvim-tree
    use({ "kyazdani42/nvim-tree.lua", requires = "kyazdani42/nvim-web-devicons" })

    -- Tab view (keep tabbed windows on the right while nvim-tree on the left)
    use({ "akinsho/bufferline.nvim", requires = { "kyazdani42/nvim-web-devicons", "moll/vim-bbye" } })
    --use { "romgrk/barbar.nvim", requires = "kyazdani42/nvim-web-devicons" }

    -- lualine
    --use { "nvim-lualine/lualine.nvim", requires = { "kyazdani42/nvim-web-devicons" } }
    --use { "arkav/lualine-lsp-progress" }

    -- Telescope
    use({ "nvim-telescope/telescope.nvim", requires = { "nvim-lua/plenary.nvim" } })
    use({ "nvim-telescope/telescope-ui-select.nvim" } )

    -- Dashboard
    use({ "glepnir/dashboard-nvim" })

    -- Session management
    --use({ "ahmedkhalf/project.nvim" })
    use({ "Shatur/neovim-session-manager", requires = { "nvim-lua/plenary.nvim" } })

    -- Treesitter
    use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" })

    -- LSP
    use({ "neovim/nvim-lspconfig" })
    -- -- Replace text kind description with icons
    use({ "onsails/lspkind-nvim" })

    -- Debug
    use({ "mfussenegger/nvim-dap" })
    use({ "theHamsta/nvim-dap-virtual-text" })
    use({ "rcarriga/nvim-dap-ui" })
    use({ "nvim-telescope/telescope-dap.nvim" })
    --use({ "Pocco81/dap-buddy.nvim" }) -- Broken? Install DAP for each language manually.
    --use({ "puremourning/vimspector" })

    -- Code outline
    use({ "stevearc/aerial.nvim" })

    -- CMake support
    use({ "Shatur/neovim-cmake", requires = { "nvim-lua/plenary.nvim", "mfussenegger/nvim-dap" } })

    -- Colorschemes
    --use({ "folke/tokyonight.nvim" })
    --use({ "mhartington/oceanic-next" })
    --use({ "ful1e5/onedark.nvim" })
    use({ "EdenEast/nightfox.nvim" })
    --use { "ellisonleao/gruvbox.nvim", requires = { "rktjmp/lush.nvim" } }
    --use { "shaunsingh/nord.nvim" }

    -- Git
    use({ "lewis6991/gitsigns.nvim" })
    use({ "kdheepak/lazygit.nvim" })

    -- Auto completion
    use({ "hrsh7th/nvim-cmp" })
    -- -- Snippet engine
    use({ "hrsh7th/vim-vsnip" })
    -- -- Sources
    use({ "hrsh7th/cmp-vsnip" })
    use({ "hrsh7th/cmp-nvim-lsp" }) -- { name = nvim_lsp }
    --use({ "hrsh7th/cmp-buffer" }) -- { name = "buffer" },
    use({ "hrsh7th/cmp-path" }) -- { name = "path" }
    --use({ "hrsh7th/cmp-cmdline" }) -- { name = "cmdline" }
    -- -- Common Snipplets
    use({ "rafamadriz/friendly-snippets" })

    -- code format
    use({ "mhartington/formatter.nvim" })

    -- auto save
    use({ "Pocco81/AutoSave.nvim" })
end)

-- Plugin configurations
require("plugin_config.nvimtree")
require("plugin_config.bufferline")
--require("plugin_config/lualine")
require("plugin_config.telescope")
require("plugin_config.treesitter")
require("plugin_config.lspconfig")
--require("plugin_config.lspkind")
require("plugin_config.cmp")
require("plugin_config.formatter")
require("plugin_config.dashboard")
--require("plugin_config.project")
require("plugin_config.nightfox")
require("plugin_config.gitsigns")
require("plugin_config.cmake")
require("plugin_config.aerial")
require("plugin_config.dap")
require("plugin_config.dap_ui")
require("plugin_config.dap_virtual_text")
require("plugin_config.autosave")
require("plugin_config.session")
return packer
