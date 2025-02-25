local M = {}

local map = require('lib').map

local function setup_commands()
    vim.api.nvim_create_user_command('ToggleHardMode',
        function()
            vim.g.hard_mode_enabled = not vim.g.hard_mode_enabled
            print("Hardmode " .. (vim.g.hard_mode_enabled and "enabled" or "disabled"))
            toggle_hard_mode()
        end,
        { nargs = 0 }
    )
end

function toggle_hard_mode()
    if vim.g.hard_mode_enabled then
        map({ "n", "i" }, "<Up>", "<Nop>")
        map({ "n", "i" }, "<Down>", "<Nop>")
        map({ "n", "i" }, "<Left>", "<Nop>")
        map({ "n", "i" }, "<Right>", "<Nop>")
        map({ "n", "i" }, "<BS>", "<Nop>")
        map({ "i" }, "<Del>", "<Nop>")
    else
        map({ "n", "i" }, "<Up>", "<Up>")
        map({ "n", "i" }, "<Down>", "<Down>")
        map({ "n", "i" }, "<Left>", "<Left>")
        map({ "n", "i" }, "<Right>", "<Right>")
        map({ "n", "i" }, "<BS>", "<BS>")
        map({ "i" }, "<Del>", "<Del>")
    end
end

function M.setup()
    setup_commands()
    toggle_hard_mode()
end

return M
