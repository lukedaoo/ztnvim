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
local status_ok, packer = pcall(require, "lazy")
if not status_ok then
    return
end

-- Install your plugins here
return packer.setup({
    -- custom
    {
        "custom",
        name = "custom",
        dir = vim.fn.stdpath("config") .. "/lua/custom",
        lazy = true,
        event = "VeryLazy",
        config = function() require("custom") end,
    },
    -- colorschemes
    {
        "nyoom-engineering/oxocarbon.nvim",
        lazy = true,
        event = "VeryLazy",
    },
    {
        'projekt0n/github-nvim-theme',
        name = 'github-theme',
        event = "VeryLazy",
        lazy = true,
        config = function()
            require('github-theme').setup({})
        end,
    },
    {
        "blazkowolf/gruber-darker.nvim",
        lazy = true,
        event = "VeryLazy",
    },
    {
        "olimorris/onedarkpro.nvim",
        lazy = true,
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
        "lukas-reineke/indent-blankline.nvim",
        main = "ibl",
        lazy = true,
        opts = {},
        event = "VeryLazy",
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
        lazy = true,
        dependencies = {
            {
                "kyazdani42/nvim-web-devicons", -- optional, for file icons
                event = "VeryLazy",
            }
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
        lazy = true,
        config = function() require("plug-config/telescope") end
    },
    {
        'kevinhwang91/nvim-bqf',
        lazy = true,
        event = "VeryLazy"
    },

    -- snippets
    {
        "L3MON4D3/LuaSnip",
        event = "VeryLazy",
        version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
        lazy = true,
        -- install jsregexp (optional!).
        build = "make install_jsregexp",
        dependencies = {
            { "rafamadriz/friendly-snippets", event = "VeryLazy", },
            { "saadparwaiz1/cmp_luasnip",     event = "VeryLazy", },
        },
    },

    -- treesitter
    {
        "nvim-treesitter/nvim-treesitter",
        event = "VeryLazy",
        config = function() require('plug-config/treesitter') end,
        lazy = true,
        run = ":TSUpdate",
    },
    -- comments
    {
        "numToStr/Comment.nvim",
        event = "VeryLazy",
        lazy = true,
        config = function() require('plug-config/comment') end
    },
    -- harpoon - bookmark file tool
    {
        "ThePrimeagen/harpoon",
        event = "VeryLazy",
        branch = "harpoon2",
        lazy = true,
        config = function() require('plug-config/harpoon') end,
    },

    -- completion
    {
        "hrsh7th/nvim-cmp", -- The completion plugin
        event = "VeryLazy",
        lazy = true,
        dependencies = {
            { "hrsh7th/cmp-nvim-lsp", event = "VeryLazy", },
            { "hrsh7th/cmp-buffer",   event = "VeryLazy", },
            { "hrsh7th/cmp-path",     event = "VeryLazy", },
        },
        config = function() require('plug-config/cmp') end
    },

    -- LSP
    {
        "williamboman/mason.nvim",
        dependencies = {
            { "williamboman/mason-lspconfig.nvim", event = "VeryLazy", },
            { "neovim/nvim-lspconfig",             event = "VeryLazy", },
            -- java
            -- "mfussenegger/nvim-jdtls",
        },
        lazy = true,
        config = function()
            require('plug-config/lsp')
        end
    },
    {
        "folke/trouble.nvim",
        event = "VeryLazy",
        lazy = true,
        dependencies = { "nvim-tree/nvim-web-devicons", event = "VeryLazy", },
        config = function() require('plug-config/trouble') end
    },
    -- Notes
    {
        "nvim-neorg/neorg",
        event = "VeryLazy",
        version = "*", -- Pin Neorg to the latest stable release
        lazy = true,
        config = function() require('plug-config/neoorg') end,
    },
    {
        "dhruvasagar/vim-table-mode",
        lazy = true,
        event = "VeryLazy",
    },
    {
        "3rd/image.nvim",
        event = "VeryLazy",
        lazy = true,
        config = function() require('plug-config/image') end,
    },
    {
        "wakatime/vim-wakatime",
        lazy = true,
        event = "VeryLazy"
    },
    {
        "zbirenbaum/copilot.lua",
        cmd = "Copilot",
        event = "VeryLazy",
        lazy = true,
        config = function() require("plug-config/copilot") end,
    }
})
