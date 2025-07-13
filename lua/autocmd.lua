-- Highlight current line
vim.cmd([[
augroup BgHighlight
    autocmd WinEnter * set cul
    autocmd WinLeave * set nocul
    autocmd!
augroup END
]])

-- auto format
local function ToggleAutoFormat()
    vim.g.auto_format_enabled = not vim.g.auto_format_enabled
    print("Auto-formatting " .. (vim.g.auto_format_enabled and "enabled" or "disabled"))
end

vim.api.nvim_create_user_command(
    'ToggleAutoFormat',
    ToggleAutoFormat,
    { nargs = 0 }
)

vim.api.nvim_create_autocmd("BufWritePre", {
    group = vim.api.nvim_create_augroup("AutoSave", { clear = true }),
    pattern = "*",
    callback = function()
        if vim.g.auto_format_enabled == false then return end
        local ignore_files_type = { "java", "h" } -- List of file types to ignore
        if vim.tbl_contains(ignore_files_type, vim.bo.filetype) then
            return
        end
        vim.lsp.buf.format({ async = true })
    end,
})

-- open pdf files with zathura
vim.cmd([[autocmd BufEnter *.pdf execute "!zathura '%'" | bdelete %]])

-- set conceallevel to 0 for some filetypes
vim.cmd [[
augroup ConcealFileTypes
    autocmd!
    autocmd FileType json,markdown,help,tex setlocal conceallevel=0
augroup END
]]

-- show line count after yanking
vim.api.nvim_create_autocmd("TextYankPost", {
    group = vim.api.nvim_create_augroup("YankLineCount", { clear = true }),
    callback = function()
        local register_content = vim.fn.getreg('"')
        local line_count = #vim.split(register_content, "\n") - 1
        vim.notify("Yanked " .. line_count .. " lines")
    end,
})

-- skip opening media files
vim.api.nvim_create_autocmd("BufReadPre", {
    pattern = { "*.gif", "*.png", "*.jpg", "*.jpeg", "*.mp4", "*.webp" },
    callback = function()
        print("Skipped opening media file.")
        vim.cmd("bdelete")
    end,
})

-- relative line number when not in insert mode
vim.api.nvim_create_autocmd({ "BufEnter", "FocusGained", "InsertLeave", "CmdlineLeave", "WinEnter" }, {
    pattern = "*",
    group = augroup,
    callback = function()
        if vim.o.nu and vim.api.nvim_get_mode().mode ~= "i" then
            vim.opt.relativenumber = true
        end
    end,
})

vim.api.nvim_create_autocmd({ "BufLeave", "FocusLost", "InsertEnter", "CmdlineEnter", "WinLeave" }, {
    pattern = "*",
    group = augroup,
    callback = function()
        if vim.o.nu then
            vim.opt.relativenumber = false
            -- Conditional taken from https://github.com/rockyzhang24/dotfiles/commit/03dd14b5d43f812661b88c4660c03d714132abcf
            -- Workaround for https://github.com/neovim/neovim/issues/32068
            if not vim.tbl_contains({ "@", "-" }, vim.v.event.cmdtype) then
                vim.cmd "redraw"
            end
        end
    end,
})

-- disable automatic comment on newline
vim.api.nvim_create_autocmd("FileType", {
    pattern = "*",
    callback = function()
        vim.opt_local.formatoptions:remove({ "c", "r", "o" })
    end,
})
