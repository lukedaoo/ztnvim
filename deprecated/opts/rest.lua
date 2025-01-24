local rest_status, rest = pcall(require, "rest-nvim")

if not rest_status then
    return
end

rest.setup({
    result_split_horizontal = true,
    result_split_in_place = false
})

-- REST client

local map = require("lib").map

map("n", "<leader>rn", "<cmd>vsplit rest.http<CR>")
map("n", "<leader>rr", function()
    require("rest-nvim").run()
end)
map("n", "<leader>rq", function()
    local exist = vim.fn.bufexists("rest.http")
    if not exist then
        return
    end

    local buf_index_check = vim.fn.bufwinnr("rest.http")
    if buf_index_check == -1 then
        return
    end

    local buf_index = vim.fn.bufnr("rest.http")
    local cmd = buf_index .. "bd!"
    vim.cmd(cmd)
end)
