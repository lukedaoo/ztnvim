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
    { "nyoom-engineering/oxocarbon.nvim" },
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
    -- {
    --     'akinsho/bufferline.nvim',
    --     version = "*",
    --     event = "VeryLazy",
    --     dependencies = 'nvim-tree/nvim-web-devicons',
    --     config = function()
    --         require("bufferline").setup({
    --             options = {
    --                 buffer_close_icon = '',
    --                 offsets = {
    --                     {
    --                         filetype = "NvimTree",
    --                         text = "Files Structure",
    --                         separator = true,
    --                         text_align = "left"
    --                     }
    --                 },
    --             }
    --         })
    --     end
    -- },
    -- Or with configuration
    {
        'projekt0n/github-nvim-theme',
        name = 'github-theme',
        lazy = false,    -- make sure we load this during startup if it is your main colorscheme
        priority = 1000, -- make sure to load this before all the other start plugins
        config = function()
            require('github-theme').setup({
                -- ...
            })

            vim.cmd('colorscheme github_dark')
        end,
    },
    {
        "blazkowolf/gruber-darker.nvim",
        event = "VeryLazy",
    },
    -- {
    --     "k4yt3x/ayu-vim-darker",
    --     event = "VeryLazy",
    -- },

    {
        "folke/tokyonight.nvim",
        event = "VeryLazy",
    },
    {
        "navarasu/onedark.nvim",
        event = "VeryLazy"
    },
    -- {
    --     "b4skyx/serenade",
    --     event = "VeryLazy",
    -- },
    -- {
    --     "rose-pine/neovim",
    --     event = "VeryLazy",
    -- },
    -- utilities
    {
        "nvim-lua/plenary.nvim",
        event = "VeryLazy",
    },
    {
        "nvim-lua/popup.nvim",
        event = "VeryLazy",
    },
    -- {
    --     "famiu/bufdelete.nvim",
    --     event = "VeryLazy",
    -- },
    {
        "alvarosevilla95/luatab.nvim",
        event = "VeryLazy",
        config = function() require('luatab').setup({}) end
    },
    -- {
    --     "kwkarlwang/bufjump.nvim",
    --     event = "VeryLazy",
    --     config = function() require('plug-config/bufjump') end
    -- },
    -- Folder Tree
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
    -- {
    --     "lewis6991/gitsigns.nvim",
    --     event = "VeryLazy",
    --     dependencies = { 'nvim-lua/plenary.nvim' },
    --     config = function() require('gitsigns').setup({}) end,
    -- },
    -- {
    --     "folke/zen-mode.nvim",
    --     event = "VeryLazy",
    --     config = function() require('plug-config/zen') end
    -- },

    -- file finder
    {
        "nvim-telescope/telescope.nvim",
        event = "VeryLazy",
        config = function() require('plug-config/telescope') end
    },
    -- snippets
    {
        "L3MON4D3/LuaSnip",
        event = "VeryLazy",
        version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
        -- install jsregexp (optional!).
        build = "make install_jsregexp"
    },
    -- {
    --     "rafamadriz/friendly-snippets",
    --     event = "VeryLazy",
    -- }, -- a bunch of snippets to use

    -- Treesitter
    {
        "nvim-treesitter/nvim-treesitter",
        event = "VeryLazy",
        config = function() require('plug-config/treesitter') end,
        run = ":TSUpdate",
    },
    -- Comments
    {
        "numToStr/Comment.nvim",
        event = "VeryLazy",
        config = function() require('plug-config/comment') end
    },
    -- Harpoon - bookmark file tool
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

    -- -- match tag
    -- {
    --     'andymass/vim-matchup',
    --     event = "VeryLazy",
    --     setup = function()
    --         -- may set any options here
    --         vim.g.matchup_matchparen_offscreen = { method = "popup" }
    --     end
    -- },
    -- {
    --     "mfussenegger/nvim-dap",
    --     event = "VeryLazy",
    --     dependencies = { "rcarriga/nvim-dap-ui" },
    --     config = function() require('plug-config/dap') end
    -- },

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

    -- {
    --     "simrat39/rust-tools.nvim",
    --     event = "VeryLazy",
    --     config = function() require('plug-config/rust-tools') end,
    --     ft = { "rust", "rs" },
    -- },

    -- {
    --     "NTBBloodbath/rest.nvim",
    --     event = "VeryLazy",
    --     config = function() require('plug-config/rest') end
    -- },
    -- {
    --     "windwp/nvim-autopairs",
    --     event = "VeryLazy",
    --     config = function() require("nvim-autopairs").setup {} end
    -- },

    -- {
    --     "lervag/vimtex",
    --     event = "VeryLazy",
    -- },

    -- {
    --     "akinsho/flutter-tools.nvim",
    --     event = "VeryLazy",
    --     dependencies = { "nvim-lua/plenary.nvim" },
    --     config = function() require('plug-config/flutter-tools') end
    -- },

    -- {
    --     "xiyaowong/nvim-transparent",
    --     event = "VeryLazy",
    -- },
    -- {
    --     "norcalli/nvim-colorizer.lua",
    --     event = "VeryLazy",
    --     config = function() require("colorizer").setup {} end
    -- },

    -- {
    --     "jackMort/ChatGPT.nvim",
    --     event = "VeryLazy",
    --     config = function()
    --         require("chatgpt").setup()
    --     end,
    --     dependencies = {
    --         "MunifTanjim/nui.nvim",
    --         "nvim-lua/plenary.nvim",
    --         "nvim-telescope/telescope.nvim"
    --     }
    -- },
    {
        "folke/trouble.nvim",
        event = "VeryLazy",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        opts = {
            -- your configuration comes here
            -- or leave it empty to use the default settings
            -- refer to the configuration section below
        },
        config = function() require('plug-config/trouble') end
    }
})
