local status_ok, copilot = pcall(require, "copilot")
if not status_ok then
    return
end

copilot.setup({
    suggestion = {
        enabled = true,
        auto_trigger = true,
    }
})


local suggestion = require("copilot.suggestion")
local map = require("lib").map;

map("i", "<C-o>", function()
    if suggestion.is_visible() then
        suggestion.accept()
    else
        suggestion.next()
    end
end)
