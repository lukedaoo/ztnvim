local status_ok, neorg = pcall(require, "neorg")
if not status_ok then
    return
end

local map = require("lib.core").map
neorg.setup({
    load = {
        ["core.defaults"] = {},
        ["core.completion"] = { config = { engine = "nvim-cmp", name = "[Norg]" } },
        ["core.integrations.nvim-cmp"] = {},
        ["core.concealer"] = { config = { icon_preset = "diamond" } },
        ["core.keybinds"] = {
            config = {
                config = {
                    default_keybinds = true,
                },
            },
        },
        ["core.dirman"] = {
            config = {
                workspaces = {
                    notes = "~/Notes/",
                    quick_notes = "~/Notes/quick-notes",
                    work = "~/Notes/work",
                },
                default_workspace = "notes"
            },
        },
    },
})
map("n", "<C-n>", ":Neorg")
