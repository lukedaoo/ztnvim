local ok, nvim_tree = pcall(require, "nvim-tree")
if not ok then
    return
end

nvim_tree.setup({
    sort_by = "case_sensitive",
    view = {
        adaptive_size = true,
    },
    renderer = {
        group_empty = true,
        icons = {
            glyphs = {
                git = {
                    untracked = "U",
                    unstaged = "X"
                },
            },
        },
        special_files = { ".gitignore", ".env" },
    },
    update_focused_file = {
        enable = true,
        update_cwd = true,
    },
    filters = {
        custom = { "^\\.git$" }
    },
    actions = {
        change_dir = { enable = false }
    }
})

local map = require("lib").map

map("n", "<leader>e", ":NvimTreeToggle<CR>")
