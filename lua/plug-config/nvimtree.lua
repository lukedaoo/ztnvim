local ok, nvim_tree = pcall(require, "nvim-tree")
if not ok then
    return
end

local ignored_ext = {
    ".aux", ".fls", ".fdb_latexmk", ".synctex.gz",
    ".git",
    ".DS_Store",
    "aux", "fls", "fdb_latexmk", ".git"
}

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
    },
    filters = {
        dotfiles = true,
        custom = ignored_ext,
    },
    actions = {
        change_dir = { enable = false }
    }
})

local map = require("lib").map

map("n", "<leader>e", ":NvimTreeToggle<CR>")
