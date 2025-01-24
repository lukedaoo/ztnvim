local status_ok, comment = pcall(require, "Comment")
if not status_ok then
    return
end
comment.setup({})

local map = require("lib").map

map("n", "<leader>/", "<Plug>(comment_toggle_linewise_current)");
map("v", "<leader>/", "<Plug>(comment_toggle_linewise_visual)");


local ft = require('Comment.ft')

-- 1. Using set function

ft
-- Set only line comment
    .set('conf', '#%s')
