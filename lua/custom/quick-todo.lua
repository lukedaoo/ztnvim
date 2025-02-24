local file_utils = require("custom.file-utils")

local M = {}

local function open_floating_note(opts, dir_or_file)
    local check = file_utils.isFolderOrFile(dir_or_file)

    if check == 0 then -- is a folder
        file_utils.get_filepath(dir_or_file, function(filepath)
            file_utils.open_floating_file(filepath)
        end)
    elseif check == 1 then -- is a file
        file_utils.open_floating_file(dir_or_file)
    else
        local cur_dir = vim.fn.getcwd()
        local todo_norg = vim.fn.resolve(cur_dir .. "/todo.norg")
        local todo_md = vim.fn.resolve(cur_dir .. "/todo.md")

        if vim.fn.filereadable(todo_norg) == 1 then
            file_utils.open_floating_file(todo_norg)
        elseif vim.fn.filereadable(todo_md) == 1 then
            file_utils.open_floating_file(todo_md)
        else
            local default_dir = opts.global_dir or "~/Notes"
            file_utils.get_filepath(default_dir, function(filepath)
                file_utils.open_floating_file(filepath)
            end)
        end
    end
end
-- @file_name: string - name of the file to create,
-- if nil, defaults to todo.norg
local function new_note(opts, file_name)
    local cur_dir = vim.fn.getcwd()
    if file_name == nil or file_name == "" then
        file_name = "todo.norg"
    end
    local target_file = cur_dir .. "/" .. file_name
    local resolved_target_file = vim.fn.resolve(target_file)

    print("Creating new note in " .. file_name)

    -- check if target_file exists
    local check = file_utils.isFolderOrFile(resolved_target_file)

    if check ~= 3 and check ~= 1 then
        print("Error: " .. resolved_target_file .. " is not a file or folder")
        return
    end
    local file = io.open(resolved_target_file, "w")
    if file then
        file:close()
        print("File created: " .. resolved_target_file)
        open_floating_note(opts, resolved_target_file)
    else
        print("Error creating file: " .. resolved_target_file)
    end
end

local function setup_user_commands(opts)
    -- :ToggleNote [folder or file]
    vim.api.nvim_create_user_command("ToggleNote", function(params)
        local args = vim.fn.expand(params.args)
        open_floating_note(opts, args)
    end, {
        nargs = "?",
        complete = "file",
    })
    -- :NewNote [file_name]
    vim.api.nvim_create_user_command("NewNote", function(params)
        local args = vim.fn.expand(params.args)
        new_note(opts, args)
    end, {
        nargs = "?",
        complete = "file",
    })
end

local function setup_keymaps()
    vim.keymap.set("n", "<leader>td", ":ToggleNote<CR>", {
        silent = true, desc = "Toggle todo note" })
    vim.keymap.set("n", "<leader>nn", ":NewNote todo.norg<CR>",
        { silent = true, desc = "Create new note in current directory" })
    vim.keymap.set("n", "<leader>ni", ":ToggleNote ~/Notes/ideas.norg<CR>",
        { silent = true, desc = "New ideas" })
end

M.setup = function(opts)
    opts = opts or {}
    setup_user_commands(opts)
    setup_keymaps()
end

return M
