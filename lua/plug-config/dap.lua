local dap_status, dap = pcall(require, "dap")

if not dap_status then
    return
end

local ok, dapui = pcall(require, "dapui")

if not ok then
    return
end

local option = {
    breakpoint = {
        text = "",
        texthl = "DiagnosticSignError",
        linehl = "",
        numhl = "",
    },
    breakpoint_rejected = {
        text = "",
        texthl = "LspDiagnosticsSignHint",
        linehl = "",
        numhl = "",
    },
    stopped = {
        text = "",
        texthl = "DiagnosticSignWarn",
        linehl = "Visual",
        numhl = "DiagnosticSignWarn",
    },
    ui = {
        auto_open = true,
    },

}

vim.fn.sign_define("DapBreakpoint", option.breakpoint)
vim.fn.sign_define("DapBreakpointRejected", option.breakpoint_rejected)
vim.fn.sign_define("DapStopped", option.stopped)

dapui.setup({
    icons = { expanded = "▾", collapsed = "▸", current_frame = "▸" },
    mappings = {
        -- Use a table to apply multiple mappings
        expand = { "<CR>", "<2-LeftMouse>" },
        open = "o",
        remove = "d",
        edit = "e",
        repl = "r",
        toggle = "t",
    },
    -- Expand lines larger than the window
    -- Requires >= 0.7
    expand_lines = vim.fn.has("nvim-0.7"),
    -- Layouts define sections of the screen to place windows.
    -- The position can be "left", "right", "top" or "bottom".
    -- The size specifies the height/width depending on position. It can be an Int
    -- or a Float. Integer specifies height/width directly (i.e. 20 lines/columns) while
    -- Float value specifies percentage (i.e. 0.3 - 30% of available lines/columns)
    -- Elements are the elements shown in the layout (in order).
    -- Layouts are opened in order so that earlier layouts take priority in window sizing.
    layouts = {
        {
            elements = {
                -- Elements can be strings or table with id and size keys.
                { id = "scopes", size = 0.25 },
                "breakpoints",
                "stacks",
                "watches",
            },
            size = 40, -- 40 columns
            position = "left",
        },
        {
            elements = {
                "repl",
                "console",
            },
            size = 0.25, -- 25% of total lines
            position = "bottom",
        },
    },
    controls = {
        -- Requires Neovim nightly (or 0.8 when released)
        enabled = true,
        -- Display controls in this element
        element = "repl",
        icons = {
            pause = "",
            play = "",
            step_into = "",
            step_over = "",
            step_out = "",
            step_back = "",
            run_last = "↻",
            terminate = "□",
        },
    },
    floating = {
        max_height = nil, -- These can be integers or a float between 0 and 1.
        max_width = nil, -- Floats will be treated as percentage of your screen.
        border = "single", -- Border style. Can be "single", "double" or "rounded"
        mappings = {
            close = { "q", "<Esc>" },
        },
    },
    windows = { indent = 1 },
    render = {
        max_type_length = nil, -- Can be integer or nil.
        max_value_lines = 100, -- Can be integer or nil.
    }
})

if option.ui.auto_open == true
then
    dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open({})
    end
end

local map = require("lib.core").map

map("n", "<leader>dt", function()
    require("dap").toggle_breakpoint()
end)

map("n", "<leader>dT", function()
    require("dap")
        .set_breakpoint(vim.fn.input("[Condition] > "))
end)

map("n", "<leader>dc", function()
    require("dap").continue()
end)

map("n", "<leader>dC", function()
    require("dap").run_to_cursor()
end)

map("n", "<leader>db", function()
    require("dap").step_back()
end)

map("n", "<leader>di", function()
    require("dap").step_into()
end)
map("n", "<leader>do", function()
    require("dap").step_over()
end)
map("n", "<leader>du", function()
    require("dap").step_back()
end)

map("n", "<leader>dp", function()
    require("dap").pause()
end)

map("n", "<leader>dd", function()
    require("dap").disconnect()
end)

map("n", "<leader>dq", function()
    require("dap").terminate()
end)

map("n", "<leader>dr", function()
    require("dap").repl.toggle()
end)

map("n", "<leader>dU", function()
    require("dapui").toggle({})
end)
