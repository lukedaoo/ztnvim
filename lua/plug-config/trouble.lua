local status_ok, trouble = pcall(require, "trouble")
if not status_ok then
    return
end
trouble.setup()
local map = require("lib").map


map("n", "<leader>xx", ":Trouble diagnostics toggle<CR>")
map("n", "<leader>xX", ":Trouble diagnostics toggle filter.buf=0<CR>")
map("n", "<leader>xq", "Trouble qflist toggle<cr>")
