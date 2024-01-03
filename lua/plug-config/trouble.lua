local status_ok, zen = pcall(require, "trouble")
if not status_ok then
    return
end

local map = require("lib.core").map


map("n", "<leader>xx", function() require("trouble").toggle() end)
map("n", "<leader>xw", function() require("trouble").toggle("workspace_diagnostics") end)
map("n", "<leader>xd", function() require("trouble").toggle("document_diagnostics") end)
map("n", "<leader>xq", function() require("trouble").toggle("quickfix") end)
map("n", "<leader>xl", function() require("trouble").toggle("loclist") end)
map("n", "<leader>gR", function() require("trouble").toggle("lsp_references") end)
