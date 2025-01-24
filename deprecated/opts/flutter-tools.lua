local status, ft = pcall(require, "flutter-tools")

if not status then
    return
end

local on_attach = require("lsp.default-config").on_attach

local flutter_on_attach = function(client, bufnr)
    on_attach(client, bufnr)
end

ft.setup {
    debugger = {
        enabled = true,
        run_via_dap = true,
    },
    outline = { auto_open = false },
    decorations = {
        statusline = { device = true, app_version = true },
    },
    widget_guides = { enabled = true, debug = true },
    dev_log = { enabled = false, open_cmd = "tabedit" },
    lsp = {
        settings = {
            showTodos = true,
            renameFilesWithClasses = "prompt",
        },
        on_attach = flutter_on_attach
    },
}

require("telescope").load_extension("flutter")
