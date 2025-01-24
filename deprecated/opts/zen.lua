local status_ok, zen = pcall(require, "zen-mode")
if not status_ok then
    return
end

zen.setup({})


local map = require("lib").map
map("n", "Z", function()
    zen.toggle({
        window = { width = .6 }
    })
end)
