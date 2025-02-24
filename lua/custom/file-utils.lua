local M = {}

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
M.isFolderOrFile = isFolderOrFile

return M
