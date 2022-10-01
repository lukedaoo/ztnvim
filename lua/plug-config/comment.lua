local status_ok, comment = pcall(require, "Comment")
if not status_ok then
    return
end
comment.setup({})

local map = require("lib.core").map

map("n", "<leader>/", "<Plug>(comment_toggle_linewise_current)");
map("v", "<leader>/", "<Plug>(comment_toggle_linewise_visual)");
