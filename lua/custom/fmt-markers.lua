local M = {}

-- { off, on }. A single entry means the tool only has an ignore-next marker.
local MARKERS = {
    python     = { "# fmt: off", "# fmt: on" },
    c          = { "// clang-format off", "// clang-format on" },
    cpp        = { "// clang-format off", "// clang-format on" },
    java       = { "// @formatter:off", "// @formatter:on" },
    lua        = { "-- stylua: ignore start", "-- stylua: ignore end" },
    markdown   = { "<!-- prettier-ignore-start -->", "<!-- prettier-ignore-end -->" },
    javascript = { "// prettier-ignore" },
    typescript = { "// prettier-ignore" },
    rust       = { "#[rustfmt::skip]" },
}

local function protect(first, last)
    local markers = MARKERS[vim.bo.filetype]
    if not markers then
        vim.notify("No formatter markers for " .. vim.bo.filetype, vim.log.levels.WARN)
        return
    end

    local indent = vim.fn.getline(first):match("^%s*")
    -- insert the end marker first so `first` stays valid
    if markers[2] then
        vim.api.nvim_buf_set_lines(0, last, last, false, { indent .. markers[2] })
    end
    vim.api.nvim_buf_set_lines(0, first - 1, first - 1, false, { indent .. markers[1] })
end

function M.setup()
    vim.api.nvim_create_user_command("FmtOff", function(args)
        protect(args.line1, args.line2)
    end, { range = true })

    vim.keymap.set("n", "<leader>nf", "<cmd>FmtOff<cr>", { desc = "Formatter off (line)" })
    vim.keymap.set("x", "<leader>nf", ":FmtOff<cr>", { desc = "Formatter off (selection)" })
end

return M
