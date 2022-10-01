local ok, nvim_tree = pcall(require, "nvim-tree")
if not ok then
    return
end

require("nvim-tree").setup({
    ignore_buffer_on_setup = true,
    sort_by = "case_sensitive",
    view = {
        adaptive_size = true,
        mappings = {
            list = {
                { key = "u", action = "dir_up" },
            },
        },
    },
    renderer = {
        group_empty = true,
        icons = {
            glyphs = {
                git = {
                    untracked = "U",
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
