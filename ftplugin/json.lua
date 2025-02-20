if vim.g.colors_name == "gruber-darker" then
    color = require("gruber-darker.palette").yellow
    colorAsHex = color:to_string()
    vim.api.nvim_set_hl(0, "@property", { fg = colorAsHex })
end
