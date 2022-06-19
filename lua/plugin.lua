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
    use { "akinsho/bufferline.nvim", requires = { "kyazdani42/nvim-web-devicons", "moll/vim-bbye" } }
    --use { 'romgrk/barbar.nvim', requires = 'kyazdani42/nvim-web-devicons' }

    -- lualine
    --use { "nvim-lualine/lualine.nvim", requires = { "kyazdani42/nvim-web-devicons" } }
    --use { "arkav/lualine-lsp-progress" }

    -- telescope
    use { "nvim-telescope/telescope.nvim", requires = { "nvim-lua/plenary.nvim" } }
    
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
require('plugin_config/nvimtree')
require('plugin_config/bufferline')
require('plugin_config/nightfox')
--require('plugin_config/lualine')
--return packer
