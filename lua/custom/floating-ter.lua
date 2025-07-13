local M = {}

-- Terminal buffer tracking
local terminal_buffers = {}

-- Floating terminal tracking
local floating_term_buf = nil
local floating_term_win = nil

-- Update terminal last-used time
local function update_terminal_buffer_time()
    local bufnr = vim.api.nvim_get_current_buf()
    if vim.bo[bufnr].buftype == 'terminal' then
        terminal_buffers[bufnr] = os.time()
    end
end

vim.api.nvim_create_autocmd("BufEnter", {
    pattern = "term://*",
    callback = update_terminal_buffer_time,
})
vim.api.nvim_create_autocmd("TermOpen", {
    pattern = "*",
    callback = update_terminal_buffer_time,
})

local function find_most_recent_terminal_buffer()
    local most_recent_bufnr = nil
    local most_recent_time = 0
    for bufnr, last_visited in pairs(terminal_buffers) do
        if last_visited > most_recent_time then
            most_recent_time = last_visited
            most_recent_bufnr = bufnr
        end
    end
    return most_recent_bufnr
end

local function focus_bufnr(bufnr)
    if bufnr < 0 or not vim.api.nvim_buf_is_valid(bufnr) then return end

    -- If it's already in a floating terminal, focus that window
    if floating_term_win
        and vim.api.nvim_win_is_valid(floating_term_win)
        and vim.api.nvim_win_get_buf(floating_term_win) == bufnr then
        vim.api.nvim_set_current_win(floating_term_win)
        return
    end

    -- Try to find a normal window with this buffer
    for _, win in ipairs(vim.api.nvim_list_wins()) do
        if vim.api.nvim_win_get_buf(win) == bufnr then
            vim.api.nvim_set_current_win(win)
            return
        end
    end

    -- If not visible, show it in a new floating window
    local width = math.floor(vim.o.columns * 0.8)
    local height = math.floor(vim.o.lines * 0.8)
    local row = math.floor((vim.o.lines - height) / 2)
    local col = math.floor((vim.o.columns - width) / 2)

    floating_term_buf = bufnr
    floating_term_win = vim.api.nvim_open_win(bufnr, true, {
        relative = "editor",
        row = row,
        col = col,
        width = width,
        height = height,
        style = "minimal",
        border = "rounded",
    })

    vim.api.nvim_set_current_win(floating_term_win)

    -- Enter insert mode if it's a terminal
    if vim.bo[bufnr].buftype == "terminal" then
        vim.cmd("startinsert")
    end
end

-- Create a new floating terminal
local function create_floating_terminal()
    local width = math.floor(vim.o.columns * 0.8)
    local height = math.floor(vim.o.lines * 0.8)
    local row = math.floor((vim.o.lines - height) / 2)
    local col = math.floor((vim.o.columns - width) / 2)

    floating_term_buf = vim.api.nvim_create_buf(false, true)
    floating_term_win = vim.api.nvim_open_win(floating_term_buf, true, {
        relative = "editor",
        row = row,
        col = col,
        width = width,
        height = height,
        style = "minimal",
        border = "rounded",
    })

    vim.cmd("terminal")
    vim.cmd("startinsert")
end

function M.toggle_term()
    -- If floating terminal is open, close it
    if floating_term_win and vim.api.nvim_win_is_valid(floating_term_win) then
        vim.api.nvim_win_close(floating_term_win, true)
        floating_term_win = nil
        floating_term_buf = nil
        return
    end

    local bufnr = find_most_recent_terminal_buffer()

    -- No terminal yet? Open new floating terminal
    if bufnr == nil or not vim.api.nvim_buf_is_loaded(bufnr) then
        create_floating_terminal()
        return
    end

    -- If in terminal, go back to previous buffer
    if vim.bo[vim.api.nvim_get_current_buf()].buftype == 'terminal' then
        focus_bufnr(vim.fn.bufnr("#"))
        return
    end

    -- Otherwise, go to most recent terminal buffer
    focus_bufnr(bufnr)
end

function M.setup_keymaps()
    local map = require("lib").map
    map("n", "<leader>tt", function() M.toggle_term() end, { noremap = true, silent = true })
end

function M.setup()
    M.setup_keymaps()
end

return M
