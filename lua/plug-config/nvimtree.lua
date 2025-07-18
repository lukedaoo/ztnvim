local ok, nvim_tree = pcall(require, "nvim-tree")
if not ok then
    return
end

local to_hide = {
    "^\\.git$" -- git folder
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
        special_files = { ".gitignore", ".env" },
    },
    update_focused_file = {
        enable = true,
        update_cwd = true,
    },
    filters = {
        dotfiles = false, -- show dotfiles
        custom = to_hide,
    },
    actions = {
        change_dir = { enable = false }
    }
})

local map = require("lib").map

map("n", "<leader>e", ":NvimTreeToggle<CR>")


vim.api.nvim_create_autocmd("BufEnter", {
    pattern = "*",
    callback = function()
        if #vim.api.nvim_list_bufs() == 1 and vim.bo.filetype == "NvimTree" then
            vim.cmd("quit")
        end
    end,
})
