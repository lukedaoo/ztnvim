-- making nvim split more obvious
vim.cmd [[

augroup BgHighlight
    autocmd!
    autocmd WinEnter * set cul
    autocmd WinLeave * set nocul
augroup END

]]

-- formatting after saved
vim.cmd [[

let ignore_files_type = ["java"] 
augroup AutoSave
    autocmd!
    autocmd BufWritePre * if index(ignore_files_type, &ft) < 0 | lua vim.lsp.buf.formatting_sync()
augroup END

]]
