local status_ok, telescope = pcall(require, "telescope")
if not status_ok then
    return
end

local ignores_file = {
    -- global
    ".git", ".zsh_", ".vscode/extensions", ".DS_Store",
    -- JS
    "node_modules", ".npm",
    -- Java
    "target", ".settings", ".idea", ".m2", ".metadata", "mvnw*",
    -- Rust
    ".lock"
}

telescope.setup({
    defaults = {
        file_sorter = require("telescope.sorters").get_fzy_sorter,
        seletion_caret = " ",
        prompt_prefix = " ",
        color_devicons = true,
        initial_mode = "normal",
        path_display = { "smart" },
        file_ignore_patterns = ignores_file,
        file_previewer = require("telescope.previewers").vim_buffer_cat.new,
        grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
        qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,

        borderchars = { "", "", "", "", "", "", "", "" },

        mappings = {
            i = {
                ["<C-x>"] = false,
                ["<C-q>"] = require("telescope.actions").send_to_qflist,
            },
        },

        layout_strategy = "horizontal",
        layout_config = {
            width = 150,
            height = 450,
            preview_width = 0.7,
            prompt_position = "bottom",
            preview_cutoff = 40,
        },

    },
    pickers = {
        colorscheme = {
            enable_preview = true
        },
    },
})

-- telescope.load_extension("git_worktree")
-- telescope.load_extension("media_files")
--
-- telescope.load_extension("flutter")
local map = require("lib").map

map("n", "<C-f>", ":Telescope")

map("n", "<leader>fS", function()
    require('telescope.builtin').grep_string({ search = vim.fn.input("Grep For > ") })
end)

map("n", "<leader>ff", function()
    require('telescope.builtin').find_files()
end)

map("n", "<leader>fg", function()
    require('telescope.builtin').git_files()
end)

map("n", "<leader>fs", function()
    require('telescope.builtin').grep_string({ search = vim.fn.expand('<cword>') })
end)

map("n", "<leader>gf", function()
    require('telescope.builtin').git_files()
end)

map("n", "<leader>gb", function()
    require('telescope.builtin').git_branches()
end)
