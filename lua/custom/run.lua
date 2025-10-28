-- https://github.com/Hubro/nvim-splitrun

local M = {
    buffer_name_fmt = "[Run #%s]",
    buffer_counter = 1,
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

function M.setup(_)
    M.define_commands()
end

function M.define_commands()
    local function make_run_command(name, split_type)
        vim.api.nvim_create_user_command(name, function(command)
            M.splitrun(command.args, { force_split_type = split_type })
        end, {
            nargs = "+",
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
