if vim.g.colors_name == "gruber-darker" then
    vim.api.nvim_set_hl(0, "@property", {
        fg = require("gruber-darker.palette").yellow:to_string()
    })
end
