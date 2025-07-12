local status_ok, trouble = pcall(require, "trouble")
if not status_ok then
    return
end
trouble.setup()
local map = require("lib").map

local function toggle_trouble(bufnr, retried)
    local winid = vim.fn.getqflist({ winid = 1 }).winid
    if winid == 0 then
        local diagnostics
        if bufnr then
            diagnostics = vim.diagnostic.get(bufnr)
        else
            diagnostics = vim.diagnostic.get()
        end

        if vim.tbl_isempty(diagnostics) then
            if not retried then
                -- Try once more in case diagnostics are delayed
                vim.defer_fn(function()
                    toggle_trouble(bufnr, true)
                end, 100) -- retry after 100ms
            else
                vim.notify("No diagnostics found", vim.log.levels.INFO)
            end
            return
        end
        vim.fn.setqflist({}, ' ', {
            title = 'Diagnostics (current buffer)',
            items = vim.diagnostic.toqflist(diagnostics, bufnr)
        })
        vim.cmd("copen")
    else
        vim.cmd("cclose")
    end
end

-- toggle diagnostics for workspace
map("n", "<leader>xa", function()
    toggle_trouble(nil)
end)

-- toggle diagnostics for current dir
map("n", "<leader>xx", function()
    local bufnr = vim.api.nvim_get_current_buf()
    toggle_trouble(bufnr)
end)
