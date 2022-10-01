local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
    PACKER_BOOTSTRAP = fn.system {
        "git",
        "clone",
        "--depth",
        "1",
        "https://github.com/wbthomason/packer.nvim",
        install_path,
    }
    print "Installing packer close and reopen Neovim..."
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd [[
    augroup packer_user_config
        autocmd!
        autocmd BufWritePost plugins.lua source <afile> | PackerSync
    augroup end
]]

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
    return
end

-- Have packer use a popup window
packer.init {
    display = {
        open_fn = function()
            return require("packer.util").float { border = "rounded" }
        end,
    },
}

-- Install your plugins here
return packer.startup(function(use)
    use "wbthomason/packer.nvim" -- Have packer manage itself
    -- colorscheme
    use {
        "k4yt3x/ayu-vim-darker",
        -- "ayu-theme/ayu-vim",
        "folke/tokyonight.nvim",
        "navarasu/onedark.nvim"
    }
    -- Performance turning
    use { "lewis6991/impatient.nvim" }
    -- utilities
    use {
        "nvim-lua/plenary.nvim",
        "nvim-lua/popup.nvim",
        "famiu/bufdelete.nvim"
    }
    use { "alvarosevilla95/luatab.nvim", config = "require('luatab').setup({})" }
    -- Folder Tree
    use {
        "kyazdani42/nvim-tree.lua",
        requires = {
            "kyazdani42/nvim-web-devicons", -- optional, for file icons
        },
        config = "require('plug-config/nvimtree')"
    }
    use {
        "lewis6991/gitsigns.nvim",
        requires = { 'nvim-lua/plenary.nvim' },
        config = "require('gitsigns').setup({})"
    }

    -- file finder
    use { "nvim-telescope/telescope.nvim", config = "require('plug-config/telescope')" }
    -- snippets
    use { "L3MON4D3/LuaSnip", "rafamadriz/friendly-snippets" } -- a bunch of snippets to use

    -- Treesitter
    use { "nvim-treesitter/nvim-treesitter", config = "require('plug-config/treesitter')", run = ":TSUpdate", }
    -- Comments
    use { "numToStr/Comment.nvim", config = "require('plug-config/comment')" }
    -- Harpoon - bookmark file tool
    use { "ThePrimeagen/harpoon", config = "require('plug-config/harpoon')", after = { "telescope.nvim" } }

    -- completion
    use {
        "hrsh7th/nvim-cmp", -- The completion plugin
        requires = {
            { "hrsh7th/cmp-nvim-lsp" },
            { "hrsh7th/cmp-buffer" }, -- buffer completions
            { "hrsh7th/cmp-path", after = "nvim-cmp" }, -- path completions
            -- use("hrsh7th/cmp-cmdline" -- cmdline completions
            { "saadparwaiz1/cmp_luasnip", after = { "nvim-cmp", "LuaSnip" } }, -- snippet completions
        },
        after = { "cmp-nvim-lsp" },
        config = "require('plug-config/cmp')"
    }

    -- LSP
    use {
        "williamboman/mason.nvim",
        requires = {
            { "williamboman/mason-lspconfig.nvim" },
            { "neovim/nvim-lspconfig" },
            -- java
            { "mfussenegger/nvim-jdtls" }
        },
        after = { "cmp-nvim-lsp" },
        config = "require('plug-config/lsp')"
    }

    -- Debug tool
    use {
        "mfussenegger/nvim-dap",
        requires = { { "rcarriga/nvim-dap-ui" } },
        after = "nvim-dap-ui",
        config = "require('plug-config/dap')"
    }

    -- Null-ls - linter
    -- use "jose-elias-alvarez/null-ls.nvim"
    -- Automatically set up your configuration after cloning packer.nvim
    -- Put this at the end after all plugins
    if PACKER_BOOTSTRAP then
        require("packer").sync()
    end
end)
