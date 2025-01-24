local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

-- Autocommand that reloads neovim whenever you save the plugins.lua file
local status_ok, packer = pcall(require, "lazy")
if not status_ok then
    return
end

-- Install your plugins here
return packer.setup({
    -- colorschemes
    { "nyoom-engineering/oxocarbon.nvim" },
    {
        'projekt0n/github-nvim-theme',
        name = 'github-theme',
        event = "VeryLazy",
        config = function()
            require('github-theme').setup({
            })
        end,
    },
    {
        "blazkowolf/gruber-darker.nvim",
        event = "VeryLazy",
    },
    {
        "olimorris/onedarkpro.nvim",
        event = "VeryLazy"
    },
    -- utilities
    {
        "nvim-lua/plenary.nvim",
        event = "VeryLazy",
    },
    {
        "nvim-lua/popup.nvim",
        event = "VeryLazy",
    },
    {
        "alvarosevilla95/luatab.nvim",
        event = "VeryLazy",
        config = function() require('luatab').setup({}) end
    },
    {
        "lukas-reineke/indent-blankline.nvim",
        main = "ibl",
        opts = {},
        config = function()
            require("ibl").setup({
                indent = {
                    char = "▏", -- This is a slightly thinner char than the default one, check :help ibl.config.indent.char
                },
                scope = {
                    show_start = false,
                    show_end = false,
                },
            })
            -- disable indentation on the first level
            local hooks = require("ibl.hooks")
            hooks.register(hooks.type.WHITESPACE, hooks.builtin.hide_first_space_indent_level)
            hooks.register(hooks.type.WHITESPACE, hooks.builtin.hide_first_tab_indent_level)
        end
    },
    -- folder explorer
    {
        "kyazdani42/nvim-tree.lua",
        dependencies = {
            "kyazdani42/nvim-web-devicons", -- optional, for file icons
        },
        event = "VeryLazy",
        config = function()
            require('plug-config/nvimtree')
        end,
    },
    -- finder
    {
        "nvim-telescope/telescope.nvim",
        event = "VeryLazy",
        config = function() require("plug-config/telescope") end
    },
    -- snippets
    {
        "L3MON4D3/LuaSnip",
        event = "VeryLazy",
        version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
        -- install jsregexp (optional!).
        build = "make install_jsregexp"
    },

    -- treesitter
    {
        "nvim-treesitter/nvim-treesitter",
        event = "VeryLazy",
        config = function() require('plug-config/treesitter') end,
        run = ":TSUpdate",
    },
    -- comments
    {
        "numToStr/Comment.nvim",
        event = "VeryLazy",
        config = function() require('plug-config/comment') end
    },
    -- harpoon - bookmark file tool
    {
        "ThePrimeagen/harpoon",
        event = "VeryLazy",
        config = function() require('plug-config/harpoon') end,
    },

    -- completion
    {
        "hrsh7th/nvim-cmp", -- The completion plugin
        event = "VeryLazy",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",          -- buffer completions
            "hrsh7th/cmp-path",            -- path completions
            -- use("hrsh7th/cmp-cmdline" -- cmdline completions
            "saadparwaiz1/cmp_luasnip", }, -- snippet completions
        config = function() require('plug-config/cmp') end
    },

    -- LSP
    {
        "williamboman/mason.nvim",
        dependencies = {
            "williamboman/mason-lspconfig.nvim",
            "neovim/nvim-lspconfig",
            -- java
            -- "mfussenegger/nvim-jdtls",
        },
        config = function()
            require('plug-config/lsp')
        end
    },
    {
        "folke/trouble.nvim",
        event = "VeryLazy",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function() require('plug-config/trouble') end
    },
    -- Notes
    {
        "nvim-neorg/neorg",
        event = "VeryLazy",
        version = "*", -- Pin Neorg to the latest stable release
        config = function() require('plug-config/neoorg') end,
    },
    {
        "dhruvasagar/vim-table-mode",
        event = "VeryLazy",
    },
    {
        "3rd/image.nvim",
        event = "VeryLazy",
        opts = {}
    },
})
