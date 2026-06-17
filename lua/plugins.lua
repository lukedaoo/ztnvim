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
        lazy = true,
        event = "VeryLazy",
        dir = vim.fn.stdpath("config") .. "/lua/custom",
        config = function() require("custom") end,
    },
    -- colorschemes
    {
        "nyoom-engineering/oxocarbon.nvim",
        lazy = true,
        event = "VeryLazy",
    },
    {
        "dgrco/deepwater.nvim",
        lazy = false,
        priority = 1000,
        config = function()
            vim.cmd.colorscheme("deepwater")
        end,
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
    {
        "hedyhli/outline.nvim",
        lazy = true,
        cmd = { "Outline", "OutlineOpen" },
        keys = {
            { "<leader>o", "<cmd>Outline<CR>", desc = "Toggle outline" },
        },
        config = function()
            require("plug-config/outline")
        end,
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
        config = function() require("plug-config/telescope_") end
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
        "romus204/tree-sitter-manager.nvim",
        dependencies = {}, -- tree-sitter CLI must be installed system-wide
        config = function()
            require("tree-sitter-manager").setup()
        end,
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
            { "hrsh7th/cmp-nvim-lsp",        event = "VeryLazy", },
            { "hrsh7th/cmp-buffer",          event = "VeryLazy", },
            { "hrsh7th/cmp-path",            event = "VeryLazy", },
            { "nvim-tree/nvim-web-devicons", event = "VeryLazy" },
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
        event = "VeryLazy",
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

    {
        'chomosuke/typst-preview.nvim',
        lazy = false, -- or ft = 'typst'
        version = '1.*',
        opts = {},    -- lazy.nvim will implicitly calls `setup {}`
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
        init = function()
            vim.g.table_mode_map_prefix = "<leader>tm"
        end,
    },
    {
        'MeanderingProgrammer/render-markdown.nvim',
        after = { 'nvim-treesitter' },
        config = function()
            require('render-markdown').setup({})
        end,
    },
    {
        "wakatime/vim-wakatime",
        lazy = true,
        event = "VeryLazy"
    },
    -- {
    --     "3rd/image.nvim",
    --     event = "VeryLazy",
    --     lazy = true,
    --     config = function() require('plug-config/image') end,
    -- },
    {
        "folke/todo-comments.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        opts = {
            keywords = {
                FIX = {
                    icon = " ", -- icon used for the sign, and in search results
                    color = "error", -- can be a hex color, or a named color (see below)
                    alt = { "FIXME", "BUG", "FIXIT", "ISSUE", "fix", "DEPEND", "depend", "DEPENDS", "depends" }, -- a set of other keywords that all map to this FIX keywords
                    -- signs = false, -- configure signs for some keywords individually
                },
                TODO = { icon = " ", color = "info" },
                HACK = { icon = " ", color = "warning" },
                WARN = { icon = " ", color = "warning", alt = { "WARNING", "XXX" } },
                PERF = { icon = " ", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE", "speed", "SPEED" } },
                NOTE = { icon = " ", color = "hint", alt = { "INFO" } },
                TEST = { icon = "⏲ ", color = "test", alt = { "TESTING", "PASSED", "FAILED" } },
            },
            highlight = {
                after = "fg", -- Text color of the text after the icon are the same as fg
            },
        }
    },
    -- AI
    {
        "Exafunction/windsurf.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "hrsh7th/nvim-cmp",
        },
        config = function()
            require("codeium").setup({
                -- Optionally disable cmp source if using virtual text only
                enable_cmp_source = false,
                virtual_text = {
                    enabled = true,

                    -- These are the defaults

                    -- Set to true if you never want completions to be shown automatically.
                    manual = false,
                    -- A mapping of filetype to true or false, to enable virtual text.
                    filetypes = {},
                    -- Whether to enable virtual text of not for filetypes not specifically listed above.
                    default_filetype_enabled = true,
                    -- How long to wait (in ms) before requesting completions after typing stops.
                    idle_delay = 75,
                    -- Priority of the virtual text. This usually ensures that the completions appear on top of
                    -- other plugins that also add virtual text, such as LSP inlay hints, but can be modified if
                    -- desired.
                    virtual_text_priority = 65535,
                    -- Set to false to disable all key bindings for managing completions.
                    map_keys = true,
                    -- The key to press when hitting the accept keybinding but no completion is showing.
                    -- Defaults to \t normally or <c-n> when a popup is showing.
                    accept_fallback = nil,
                    -- Key bindings for managing completions in virtual text mode.
                    key_bindings = {
                        -- Accept the current completion.
                        accept = "<C-o>",
                        -- Accept the next word.
                        accept_word = false,
                        -- Accept the next line.
                        accept_line = false,
                        -- Clear the virtual text.
                        clear = false,
                        -- Cycle to the next completion.
                        next = "<M-]>",
                        -- Cycle to the previous completion.
                        prev = "<M-[>",
                    }
                }
            })
        end
    },

    {
        "folke/sidekick.nvim",
        opts = {
        },
        keys = {
            {
                "<tab>",
                function()
                    -- if there is a next edit, jump to it, otherwise apply it if any
                    if not require("sidekick").nes_jump_or_apply() then
                        return "<Tab>" -- fallback to normal tab
                    end
                end,
                expr = true,
                desc = "Goto/Apply Next Edit Suggestion",
            },
            {
                "<c-.>",
                function() require("sidekick.cli").toggle() end,
                desc = "Sidekick Toggle",
                mode = { "n", "t", "i", "x" },
            },
            {
                "<leader>aa",
                function() require("sidekick.cli").toggle() end,
                desc = "Sidekick Toggle CLI",
            },
            {
                "<leader>as",
                function() require("sidekick.cli").select() end,
                -- Or to select only installed tools:
                -- require("sidekick.cli").select({ filter = { installed = true } })
                desc = "Select CLI",
            },
            {
                "<leader>ad",
                function() require("sidekick.cli").close() end,
                desc = "Detach a CLI Session",
            },
            {
                "<leader>at",
                function() require("sidekick.cli").send({ msg = "{this}" }) end,
                mode = { "x", "n" },
                desc = "Send This",
            },
            {
                "<leader>af",
                function() require("sidekick.cli").send({ msg = "{file}" }) end,
                desc = "Send File",
            },
            {
                "<leader>av",
                function() require("sidekick.cli").send({ msg = "{selection}" }) end,
                mode = { "x" },
                desc = "Send Visual Selection",
            },
            {
                "<leader>ap",
                function() require("sidekick.cli").prompt() end,
                mode = { "n", "x" },
                desc = "Sidekick Select Prompt",
            },
            -- Example of a keybinding to open Claude directly
            {
                "<leader>ac",
                function() require("sidekick.cli").toggle({ name = "claude", focus = true }) end,
                desc = "Sidekick Toggle Claude",
            },
        },

        {
            "ej-shafran/compile-mode.nvim",
            version = "^5.0.0",
            -- you can just use the latest version:
            -- branch = "latest",
            -- or the most up-to-date updates:
            -- branch = "nightly",
            dependencies = {
                "nvim-lua/plenary.nvim",
                -- if you want to enable coloring of ANSI escape codes in
                -- compilation output, add:
                -- { "m00qek/baleia.nvim", tag = "v1.3.0" },
            },
            config = function()
                ---@type CompileModeOpts
                vim.g.compile_mode = {
                    -- if you use something like `nvim-cmp` or `blink.cmp` for completion,
                    -- set this to fix tab completion in command mode:
                    -- input_word_completion = true,

                    -- to add ANSI escape code support, add:
                    -- baleia_setup = true,

                    -- to make `:Compile` replace special characters (e.g. `%`) in
                    -- the command (and behave more like `:!`), add:
                    -- bang_expansion = true,
                }
            end
        }
    }
})
