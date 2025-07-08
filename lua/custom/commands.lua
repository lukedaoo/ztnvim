local M = {}

local default_opts = {
    notify = true, -- show :ToggleImage status messages
    command_name = "ToggleImage",
}

local function toggle_image(opts)
    local img = require("image")

    if img.is_enabled() then
        img.disable()
        if opts.notify then
            vim.notify("image.nvim is disabled", vim.log.levels.INFO)
        end
    else
        img.enable()
        if opts.notify then
            vim.notify("image.nvim is enabled", vim.log.levels.INFO)
        end
    end
end

function M.setup(user_opts)
    local opts = vim.tbl_deep_extend("force", default_opts, user_opts or {})

    local ok = pcall(vim.api.nvim_get_autocmds, { group = "CommandsToggleImage" })
    if not ok then
        vim.api.nvim_create_augroup("CommandsToggleImage", { clear = true })
    end

    vim.api.nvim_create_user_command(
        opts.command_name,
        function() toggle_image(opts) end,
        { desc = "Toggle inline image rendering from image.nvim" }
    )
end

return M
