local M = {}

local function toggle_hard_mode()
    if vim.g.hard_mode_enabled then
        vim.keymap.set({ "n", "i" }, "<Up>", "<Nop>")
        vim.keymap.set({ "n", "i" }, "<Down>", "<Nop>")
        vim.keymap.set({ "n", "i" }, "<Left>", "<Nop>")
        vim.keymap.set({ "n", "i" }, "<Right>", "<Nop>")
        vim.keymap.set({ "n", "i" }, "<BS>", "<Nop>")
        vim.keymap.set({ "i" }, "<Del>", "<Nop>")
    else
        vim.keymap.set({ "n", "i" }, "<Up>", "<Up>")
        vim.keymap.set({ "n", "i" }, "<Down>", "<Down>")
        vim.keymap.set({ "n", "i" }, "<Left>", "<Left>")
        vim.keymap.set({ "n", "i" }, "<Right>", "<Right>")
        vim.keymap.set({ "n", "i" }, "<BS>", "<BS>")
        vim.keymap.set({ "i" }, "<Del>", "<Del>")
    end
end

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

function M.setup()
    setup_commands()
    toggle_hard_mode()
end

return M
