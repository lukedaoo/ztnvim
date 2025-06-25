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
    ensure_installed = { "lua_ls", }
    -- /"jdtls", "rust_analyzer" }
})

local lsp_handler = require("lsp.default-config")

local config = lsp_handler.default_config

-- Lua LSP
lsp_config["lua_ls"].setup(config({
    settings = {
        Lua = {
            diagnostics = {
                globals = { "vim" },
                disable = { "lowercase-global" }
            },
            workspace = {
                library = vim.api.nvim_get_runtime_file("", true),
                checkThirdParty = false,
            },
            telemetry = {
                enable = false,
            },
        },
    },
}))

-- Python
-- lsp_config["jedi_language_server"].setup(config())

-- Latex
-- lsp_config["texlab"].setup(config())
-- lsp_config["ltex"].setup(config())
-- lsp_config["dartls"].setup(config())

lsp_config["clangd"].setup(config())

lsp_config["html"].setup(config({
    init_options = {
        configurationSection = { "html", "css", "javascript" },
        embeddedLanguages = {
            css = true,
            javascript = false
        },
        provideFormatter = true
    }
}))

-- lsp_config["cssls"].setup(config())

lsp_config["ts_ls"].setup(config({
    init_options = {
        preferences = {
            disableSuggestions = true,
        }
    },
    single_file_support = true
}))

-- lsp_config["csharp_ls"].setup(config())
lsp_config["gopls"].setup(config())
