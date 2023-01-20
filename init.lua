require("settings.cache") -- use it only if my nvim is stable
require("settings.global")
require("settings.options")
require("settings.colorscheme")
require("statusline")
require("settings.ts-fix")
-- deferred execution makes the editor feel more responsive
vim.defer_fn(function()
    require("keymaps")
    require("autocmd")
    require("plugins")
end, 0)
