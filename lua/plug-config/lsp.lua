local status_mason, mason = pcall(require, "mason")
if not status_mason then return end

local status_mason_lsp_config, mason_lsp_config = pcall(require, "mason-lspconfig")
if not status_mason_lsp_config then return end

mason.setup()
mason_lsp_config.setup({
    ensure_installed = { "lua_ls" }
})

local lsp_handler = require("lsp.default-config")
local base_config = lsp_handler.default_config

-- Helper: define and enable LSP configs
local function setup_lsp(name, opts)
    local cfg = vim.lsp.config(name, base_config(opts))
    vim.lsp.enable(name, cfg)
end

-- Lua
setup_lsp("lua_ls")

-- Python
-- setup_lsp("jedi_language_server")
setup_lsp("pyright")
setup_lsp("ruff")

-- C / C++
setup_lsp("clangd")

-- HTML
setup_lsp("html", {
    init_options = {
        configurationSection = { "html", "css", "javascript" },
        embeddedLanguages = { css = true, javascript = false },
        provideFormatter = true,
    },
})

-- CSS
setup_lsp("cssls")

-- TS/JS
setup_lsp("ts_ls", {
    init_options = {
        preferences = { disableSuggestions = true },
    },
    single_file_support = true,
})

-- Go
setup_lsp("gopls")

-- Typst
setup_lsp("tinymist")

-- LaTeX (optional)
-- setup_lsp("texlab")
-- setup_lsp("ltex")
-- setup_lsp("dartls")
-- setup_lsp("csharp_ls")
