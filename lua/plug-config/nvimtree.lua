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
    },
    update_focused_file = {
        enable = true,
        update_cwd = true,
        ignore_list = {},
    },
    filters = {
        dotfiles = true,
    },
})

local map = require("lib.core").map

map("n", "<leader>e", ":NvimTreeToggle<CR>")
