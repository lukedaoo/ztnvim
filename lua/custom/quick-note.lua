local file_utils = require("custom.file-utils")

local M = {}

-- Checks if it is a folder:
--      If yes, open the folder
-- Checks if dir_or_file is a file:
--      If yes, opens it in a floating window.
-- If dir_or_file is missing or invalid:
--      Tries to open note file in the current working directory.
--      If it does not exist, open the global notes directory (opts.global_dir).
-- @opts.global_dir: The global notes directory.
-- @opts.note_name: The note file name.
local function open_floating_note(opts, dir_or_file)
    local check = file_utils.isFolderOrFile(dir_or_file)
    local floating_file = require("custom.floating-file")

    if check == 0 then -- is a folder
        file_utils.get_filepath(dir_or_file, function(file_path)
            floating_file.open(file_path)
        end)
    elseif check == 1 then -- is a file
        floating_file.open(dir_or_file)
    else
        local cur_dir = vim.fn.getcwd()
        local note_name = opts.note_name or "todo.norg"
        local todo_filepath = vim.fn.resolve(cur_dir .. "/" .. note_name)

        if vim.fn.filereadable(todo_filepath) == 1 then
            floating_file.open(todo_filepath)
        else
            local default_dir = opts.global_dir or "~/Notes"
            file_utils.get_filepath(default_dir, function(file_path)
                floating_file.open(file_path)
            end)
        end
    end
end

local function new_note(opts, file_name)
    if file_name == nil or file_name == "" then
        file_name = opts.note_name or "todo.norg"
    end
    local resolved_target_file = vim.fn.resolve(file_name)

    local check = file_utils.isFolderOrFile(resolved_target_file)

    if check ~= 3 and check ~= 1 then
        print("Error: " .. resolved_target_file .. " is not a file or folder")
        return
    end
    local file = io.open(resolved_target_file, "a")
    if file then
        file:close()
        require("custom.floating-file").open(resolved_target_file)
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
        silent = true, desc = "Toggle note folder or note file" })
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
