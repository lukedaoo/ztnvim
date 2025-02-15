vim.cmd [[
augroup BgHighlight
    autocmd WinEnter * set cul
    autocmd WinLeave * set nocul
    autocmd!
augroup END
]]

-- Function to trigger LSP format
function FormatOnSave()
    local ignore_files_type = { "java", "h" } -- List of file types to ignore
    if vim.tbl_contains(ignore_files_type, vim.bo.filetype) then
        return
    end
    vim.lsp.buf.format({ async = true })
end

-- Function to toggle the auto-formatting
function ToggleAutoFormat()
    vim.g.auto_format_enabled = not vim.g.auto_format_enabled
    print("Auto-formatting " .. (vim.g.auto_format_enabled and "enabled" or "disabled"))
end

vim.api.nvim_create_user_command(
    'ToggleAutoFormat',
    ToggleAutoFormat,
    { nargs = 0 }
)

-- formatting after saved
vim.cmd [[
augroup AutoSave
    autocmd!
    autocmd BufWritePre * lua if vim.g.auto_format_enabled then vim.lsp.buf.format({async=true}) end
augroup END

]]

vim.cmd([[autocmd BufEnter *.pdf execute "!zathura '%'" | bdelete %]])
