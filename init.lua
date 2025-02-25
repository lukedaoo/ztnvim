require("settings.global")
require("settings.options")
require("keymaps")
require("autocmd")
require("plugins")
require("lib").load_colorscheme("gruber-darker", function()
    if vim.g.colors_name == "gruber-darker" then
        vim.api.nvim_set_hl(0, "@property", {
            fg = require("gruber-darker.palette")["fg"]:to_string()
        })
    end
end)
