-- making nvim plit more obvious
vim.cmd [[

augroup BgHighlight
    autocmd WinEnter * set cul
    autocmd WinLeave * set nocul
    autocmd!
augroup END

]]
-- formatting after saved
vim.cmd [[
let ignore_files_type = ["java", "h"] 
augroup AutoSave
    autocmd!
    autocmd BufWritePre * if index(ignore_files_type, &ft) < 0 | lua vim.lsp.buf.format({async=true})
augroup END

]]

vim.cmd([[autocmd BufEnter *.pdf execute "!zathura '%'" | bdelete %]])
