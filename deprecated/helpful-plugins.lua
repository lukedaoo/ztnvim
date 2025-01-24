return {
    {
        'akinsho/bufferline.nvim',
        version = "*",
        event = "VeryLazy",
        dependencies = 'nvim-tree/nvim-web-devicons',
        config = function()
            require("bufferline").setup({
                options = {
                    buffer_close_icon = '',
                    offsets = {
                        {
                            filetype = "NvimTree",
                            text = "Files Structure",
                            separator = true,
                            text_align = "left"
                        }
                    },
                }
            })
        end
    },
    {
        "k4yt3x/ayu-vim-darker",
        event = "VeryLazy",
    },
    {
        "lewis6991/gitsigns.nvim",
        event = "VeryLazy",
        dependencies = { 'nvim-lua/plenary.nvim' },
        config = function() require('gitsigns').setup({}) end,
    },
    {
        "folke/zen-mode.nvim",
        event = "VeryLazy",
        config = function() require('plug-config/zen') end
    },

    {
        "b4skyx/serenade",
        event = "VeryLazy",
    },
    {
        "rose-pine/neovim",
        event = "VeryLazy",
    },
    {
        "famiu/bufdelete.nvim",
        event = "VeryLazy",
    },
    {
        "kwkarlwang/bufjump.nvim",
        event = "VeryLazy",
        config = function() require('plug-config/bufjump') end
    },
    {
        "rafamadriz/friendly-snippets",
        event = "VeryLazy",
    },
    {
        'andymass/vim-matchup',
        event = "VeryLazy",
        setup = function()
            vim.g.matchup_matchparen_offscreen = { method = "popup" }
        end
    },
    {
        "mfussenegger/nvim-dap",
        event = "VeryLazy",
        dependencies = { "rcarriga/nvim-dap-ui" },
        config = function() require('plug-config/dap') end
    },

    {
        "simrat39/rust-tools.nvim",
        event = "VeryLazy",
        config = function() require('plug-config/rust-tools') end,
        ft = { "rust", "rs" },
    },

    {
        "NTBBloodbath/rest.nvim",
        event = "VeryLazy",
        config = function() require('plug-config/rest') end
    },
    {
        "windwp/nvim-autopairs",
        event = "VeryLazy",
        config = function() require("nvim-autopairs").setup {} end
    },

    {
        "lervag/vimtex",
        event = "VeryLazy",
    },

    {
        "akinsho/flutter-tools.nvim",
        event = "VeryLazy",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function() require('plug-config/flutter-tools') end
    },

    {
        "xiyaowong/nvim-transparent",
        event = "VeryLazy",
    },
    {
        "norcalli/nvim-colorizer.lua",
        event = "VeryLazy",
        config = function() require("colorizer").setup {} end
    },

    {
        "jackMort/ChatGPT.nvim",
        event = "VeryLazy",
        config = function()
            require("chatgpt").setup()
        end,
        dependencies = {
            "MunifTanjim/nui.nvim",
            "nvim-lua/plenary.nvim",
            "nvim-telescope/telescope.nvim"
        }
    },
}
