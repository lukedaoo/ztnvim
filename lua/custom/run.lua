local M = {
    buffer_name_fmt = "[Run #%s]",
    buffer_counter = 1,
    bookmarks = {}, -- Store command bookmarks
}

BUFFER_OPTIONS = {
    swapfile = false,
    modifiable = false,
    bufhidden = "wipe",
    buflisted = false,
}

local function delete_alt(buf)
    local alt = vim.api.nvim_buf_call(buf, function()
        ---@diagnostic disable-next-line: redundant-return-value, param-type-mismatch
        return vim.fn.bufnr("#")
    end)
    if alt ~= buf and alt ~= -1 then
        pcall(vim.api.nvim_buf_delete, alt, { force = true })
    end
end

local function get_path_executables()
    local results = {}
    local seen = {}

    local path = vim.env.PATH or ""
    for dir in path:gmatch("[^:]+") do
        local ok, files = pcall(vim.fn.readdir, dir)
        if ok then
            for _, file in ipairs(files) do
                if not seen[file] then
                    local full = dir .. "/" .. file
                    if vim.fn.executable(full) == 1 then
                        seen[file] = true
                        table.insert(results, file)
                    end
                end
            end
        end
    end

    table.sort(results)
    return results
end

function M.setup(config)
    config = config or {}

    if config.bookmarks then
        M.bookmarks = config.bookmarks
    end

    M.define_commands()
end

function M.define_commands()
    local function make_run_command(name, split_type)
        vim.api.nvim_create_user_command(name, function(command)
            local args = command.args

            local bookmark_name = args:match("^%(([^)]+)%)$")
            if bookmark_name and M.bookmarks[bookmark_name] then
                args = M.bookmarks[bookmark_name]
            end

            M.splitrun(args, { force_split_type = split_type })
        end, {
            nargs = "+",
            complete = function(arg_lead, cmdline, cursor_pos)
                local matches = {}

                -- 1. Bookmark completion
                local inside_parens = arg_lead:match("^%((.*)$")
                if inside_parens then
                    for bookmark_name, _ in pairs(M.bookmarks) do
                        if vim.startswith(bookmark_name, inside_parens) then
                            table.insert(matches, "(" .. bookmark_name .. ")")
                        end
                    end
                    return matches
                end

                if arg_lead == "" or arg_lead == "(" then
                    for bookmark_name, _ in pairs(M.bookmarks) do
                        table.insert(matches, "(" .. bookmark_name .. ")")
                    end
                end

                -- 2. PATH executable completion
                local executables = get_path_executables()
                for _, exe in ipairs(executables) do
                    if vim.startswith(exe, arg_lead) then
                        table.insert(matches, exe)
                    end
                end

                return matches
            end,
        })
    end

    -- Default (auto layout)
    make_run_command("Run", nil)
    -- Force vertical split
    make_run_command("RunV", "vsplit")
    -- Force horizontal split
    make_run_command("RunS", "split")
end

function M.splitrun(command, opts)
    opts = opts or {}
    opts.new_split = opts.new_split or false
    opts.focus = opts.focus or true

    local win = M.prev_win

    if win == nil or not vim.api.nvim_win_is_valid(win) or opts.new_split == true then
        local split_command
        if opts.force_split_type then
            split_command = opts.force_split_type
        else
            local w = vim.api.nvim_win_get_width(0)
            local h = vim.api.nvim_win_get_height(0)
            if (w / 2.5) > h then
                split_command = "vsplit"
            else
                split_command = "split"
            end
        end

        vim.cmd(split_command)
        win = vim.api.nvim_get_current_win()
        M.prev_win = win
    end

    vim.api.nvim_win_call(win, function()
        vim.cmd("terminal " .. command)
    end)

    local buf = vim.api.nvim_win_get_buf(win)

    vim.api.nvim_buf_set_name(
        buf,
        string.format(M.buffer_name_fmt, M.buffer_counter)
    )

    -- nvim_buf_set_name creates a new buffer with the old name
    delete_alt(buf)

    vim.keymap.set("n", "<Esc>", function()
        vim.api.nvim_buf_delete(buf, { force = true })
    end, { buffer = buf })

    for option, value in pairs(BUFFER_OPTIONS) do
        vim.api.nvim_set_option_value(option, value, { buf = buf })
    end

    M.buffer_counter = M.buffer_counter + 1

    if opts.focus then
        vim.api.nvim_set_current_win(win)
        vim.cmd.startinsert()
    end
end

return M
