local M = {}
-- Open a floating window with the file content
local function open(filepath)
    local function float_win_config()
        local width = math.min(math.floor(vim.o.columns * 0.8), 64)
        local height = math.floor(vim.o.lines * 0.8)

        return {
            relative = "editor",
            width = width,
            height = height,
            col = (vim.o.columns - width) / 2,
            row = (vim.o.lines - height) / 2,
            border = "single",
        }
    end

    local path = vim.fn.expand(filepath)

    if vim.fn.filereadable(path) == 0 then
        vim.notify("File does not exist: " .. path, vim.log.levels.ERROR)
        return
    end

    local buf = vim.fn.bufnr(path, true)
    if buf == -1 then
        buf = vim.api.nvim_create_buf(false, false)
        vim.api.nvim_buf_set_name(buf, path)
        vim.api.nvim_buf_call(buf, function()
            vim.cmd("edit " .. vim.fn.fnameescape(path))
        end)
    end

    local win = vim.api.nvim_open_win(buf, true, float_win_config())
    vim.cmd("setlocal nospell")
    vim.notify("Opened " .. path, vim.log.levels.INFO)

    vim.api.nvim_buf_set_keymap(buf, "n", "<ESC>", "", {
        noremap = true,
        silent = true,
        callback = function()
            if vim.api.nvim_get_option_value("modified", { buf = buf }) then
                vim.cmd("w")
                vim.api.nvim_win_close(0, true)
            else
                vim.api.nvim_win_close(0, true)
            end
        end,
    })
    vim.api.nvim_create_autocmd("VimResized", {
        callback = function()
            vim.api.nvim_win_set_config(win, float_win_config())
        end,
        once = false,
    })
end

local function setup_command()
    vim.api.nvim_create_user_command("ToggleFile", function(params)
        local args = vim.fn.expand(params.args)
        local resolved_target_file = vim.fn.resolve(args)
        open(resolved_target_file)
    end, {
        nargs = "?",
        complete = "file",
    })
end

M.open = open
M.setup = function()
    setup_command()
end

return M
