local status_ok, comment = pcall(require, "Comment")
if not status_ok then
    return
end
comment.setup({})

local map = require("lib").map

local function toggle_comment()
    local mode = vim.api.nvim_get_mode().mode
    local line1, line2

    local upbound = vim.g.block_comment_lines or 10

    if mode == "v" or mode == "V" or mode == "\22" then
        line1 = vim.fn.line("v")
        line2 = vim.fn.line(".")
        local count = math.abs(line2 - line1) + 1 -- Calculate selected line count

        if count > upbound then
            vim.api.nvim_feedkeys("gb", "x", true)
            vim.notify("Commented out " .. count .. " lines")
        else
            vim.api.nvim_feedkeys("gcc", "x", true)
        end
    else -- Normal mode
        vim.api.nvim_feedkeys("gcc", "x", true)
    end
end

map("n", "<leader>/", toggle_comment, { noremap = true, silent = true })
map("v", "<leader>/", toggle_comment, { noremap = true, silent = true })

local ft = require('Comment.ft')

-- 1. Using set function

ft
-- Set only line comment
    .set('conf', '#%s')
