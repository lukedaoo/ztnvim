local status, rt = pcall(require, "rust-tools")

if not status then
    return
end

local on_attach = require("lsp.default-config").on_attach

local rust_on_attach = function(client, bufnr)
    on_attach(client, bufnr)
end


-- Update this Path
--
--
local opts = {
    server = {
        on_attach = rust_on_attach,
    },
}

rt.setup(opts)

local dap = require "dap"
local mason_path = vim.fn.glob(vim.fn.stdpath "data" .. "/mason/")
dap.adapters.lldb = {
    type = "server",
    port = "${port}",
    executable = {
        command = mason_path .. "bin/codelldb",
        args = { "--port", "${port}" },
        -- On windows you may have to uncomment this:
        -- detached = false,
    },
}

dap.configurations.rust = {
    {
        name = 'Launch',
        type = 'lldb',
        request = 'launch',
        program = function()
            return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/target/debug', 'file')
        end,
        cwd = '${workspaceFolder}',
        stopOnEntry = false,
        args = {},
    },
}
