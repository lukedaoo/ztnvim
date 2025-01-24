local M = {}

local map = require("lib").map

local capabilities = vim.lsp.protocol.make_client_capabilities();

local status_cmp_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not status_cmp_ok then
    return
end

capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities = cmp_nvim_lsp.default_capabilities(capabilities)

local on_attach = function()
    map("n", "gd", function()
        require('telescope.builtin').lsp_definitions(
            require('telescope.themes').get_dropdown({})
        )
    end)
    map("n", "gr", function()
        require('telescope.builtin').lsp_references(
            require('telescope.themes').get_dropdown({})
        )
    end)

    map("n", "gi", function()
        require('telescope.builtin').lsp_implementations(
            require('telescope.themes').get_dropdown({})
        )
    end)
    map("n", "<C-k>", function() vim.lsp.buf.hover() end)
    map("n", "<leader>lws", function() vim.lsp.buf.workspace_symbol() end)
    map("n", "<leader>ld", function() vim.diagnostic.open_float() end)
    map("n", "[d", function() vim.diagnostic.goto_next() end)
    map("n", "]d", function() vim.diagnostic.goto_prev() end)
    map("n", "<leader>lrn", function() vim.lsp.buf.rename() end)
    map("n", "<leader>la", function() vim.lsp.buf.code_action() end)
    map("n", "<leader>lo", function()
        vim.lsp.buf.code_action({
            filter = function(code_action)
                if not code_action or not code_action.data then
                    return false
                end

                local data = code_action.data.id
                return string.sub(data, #data - 1, #data) == ":0"
            end,
            apply = true
        })
    end)
    map("i", "<C-h>", function() vim.lsp.buf.signature_help() end)
end


local default_config = function(_config)
    return vim.tbl_deep_extend("force", {
        capabilities = capabilities,
        on_attach = on_attach
    }, _config or {})
end


M.default_config = default_config
M.capabilities = capabilities
M.on_attach = on_attach

return M
