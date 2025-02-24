-- Highlight current line
vim.cmd([[
augroup BgHighlight
    autocmd WinEnter * set cul
    autocmd WinLeave * set nocul
    autocmd!
augroup END
]])

-- formatting after saved
function FormatOnSave()
    if vim.g.auto_format_enabled == false then return end
    local ignore_files_type = { "java", "h" } -- List of file types to ignore
    if vim.tbl_contains(ignore_files_type, vim.bo.filetype) then
        return
    end
    vim.lsp.buf.format({ async = true })
end

function ToggleAutoFormat()
    vim.g.auto_format_enabled = not vim.g.auto_format_enabled
    print("Auto-formatting " .. (vim.g.auto_format_enabled and "enabled" or "disabled"))
end

vim.api.nvim_create_user_command(
    'ToggleAutoFormat',
    ToggleAutoFormat,
    { nargs = 0 }
)

vim.cmd [[
augroup AutoSave
    autocmd!
    autocmd BufWritePre * lua FormatOnSave()
augroup END
]]
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
