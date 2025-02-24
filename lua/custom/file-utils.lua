local M = {}

-- Open a floating window with the file content
local function open_floating_file(filepath)
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

-- Select a file using Telescope
local function get_filepath(folder, callback)
    local status, _ = pcall(require, "telescope")
    if not status then
        vim.notify("Telescope not found!")
        return
    end
    folder = (folder and folder ~= "") and folder or vim.fn.getcwd()
    require("telescope.builtin").find_files({
        cwd = folder, -- Set the working directory
        attach_mappings = function(prompt_bufnr, map)
            local actions = require("telescope.actions")
            local action_state = require("telescope.actions.state")

            actions.select_default:replace(function()
                actions.close(prompt_bufnr)
                local selection = action_state.get_selected_entry()
                if selection then
                    callback(selection.path) -- Return the selected file path
                end
            end)
            return true
        end,
    })
end

-- check if the input is a folder or file
-- @param input: string - the input to check
-- @return: number - the type of the input
-- 0: folder
-- 1: file
-- 2: empty string
-- 3: does not exist
local function isFolderOrFile(input)
    local args = vim.fn.expand(input)
    if args == "" then
        return 2 -- Empty input
    end

    if vim.fn.isdirectory(args) == 1 then
        return 0 -- It's a directory
    elseif vim.fn.filereadable(args) == 1 then
        return 1 -- It's a file
    else
        return 3 -- Neither a file nor a directory (probably doesn't exist)
    end
end

M.get_filepath = get_filepath
M.open_floating_file = open_floating_file
M.isFolderOrFile = isFolderOrFile

return M
