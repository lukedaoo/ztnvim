local status, rt = pcall(require, "rust-tools")

if not status then
    return
end

local on_attach = require("lsp.default-config").on_attach

local rust_on_attach = function(client, bufnr)
    on_attach(client, bufnr)
end
-- Update this path
local extension_path = vim.env.HOME .. "/Download/codelldb/extension/"
local codelldb_path = extension_path .. "adapter/codelldb"
local liblldb_path = extension_path .. "lldb/lib/liblldb.so"
print(codelldb_path)
local opts = {
    server = {
        on_attach = rust_on_attach,
    },
    dap = {
        adapter = require('rust-tools.dap').get_codelldb_adapter(
            codelldb_path, liblldb_path)
    }
}

rt.setup(opts)
