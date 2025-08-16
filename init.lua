require("settings.global")
require("settings.options")
require("keymaps")
require("autocmd")
require("plugins")
require("lib").load_colorscheme("gruber-darker", function()
    if vim.g.colors_name == "gruber-darker" then
        local palette = require("gruber-darker.palette")
        local bg_color = "#000000"

        vim.api.nvim_set_hl(0, "@property", {
            fg = palette["fg"]:to_string()
        })

        -- Active buffer
        vim.api.nvim_set_hl(0, "Normal", {
            bg = bg_color,
            fg = palette["fg"]:to_string()
        })

        -- Inactive buffer (keep same background)
        vim.api.nvim_set_hl(0, "NormalNC", {
            bg = bg_color,
            fg = palette["fg"]:to_string()
        })

        -- Optional: other UI elements
        vim.api.nvim_set_hl(0, "NormalFloat", { bg = bg_color })
        vim.api.nvim_set_hl(0, "SignColumn", { bg = bg_color })
        vim.api.nvim_set_hl(0, "EndOfBuffer", { bg = bg_color })
    end
end)
