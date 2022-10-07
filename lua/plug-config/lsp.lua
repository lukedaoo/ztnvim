local status_mason, mason = pcall(require, "mason")

if not status_mason then
    return
end

local status_mason_lsp_config, mason_lsp_config = pcall(require, "mason-lspconfig")

if not status_mason_lsp_config then
    return
end

local status_lsp_config, lsp_config = pcall(require, "lspconfig")

if not status_lsp_config then
    return
end

mason.setup()
mason_lsp_config.setup({
    ensure_installed = { "sumneko_lua", "jdlts", "pyright", "rust_analyzer", "codelldb" }
})

local lsp_handler = require("lsp.default-config")

local config = lsp_handler.default_config
local lsp_flags = {
    -- This is the default in Nvim 0.7+
    debounce_text_changes = 150,
}

-- Lua LSP
lsp_config["sumneko_lua"].setup(config({
    flags = lsp_flags,
    settings = {
        Lua = {
            runtime = {
                -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                version = 'LuaJIT',
            },
            diagnostics = {
                -- Get the language server to recognize the `vim` global
                globals = { 'vim' },
            },
            workspace = {
                -- Make the server aware of Neovim runtime files
                library = vim.api.nvim_get_runtime_file("", true),
            },
            -- Do not send telemetry data containing a randomized but unique identifier
            telemetry = {
                enable = false,
            },
        },
    },
}))

-- Python
lsp_config["pyright"].setup(config())

-- Rust
