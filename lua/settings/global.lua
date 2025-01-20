vim.loader.enable()

vim.g.do_filetype_lua = 1
vim.g.python_host_skip_check = 1

-- Disable some builtin vim plugins
local disabled_built_ins = {
    "node_provider",
    "perl_provider",
    "ruby_provider",
    "python_provider",
    "2html_plugin",
    "getscript",
    "getscriptPlugin",
    "gzip",
    "logipat",
    "netrw",
    "netrwPlugin",
    "netrwSettings",
    "netrwFileHandlers",
    "matchit",
    "matchparen",
    "tar",
    "tarPlugin",
    "rrhelper",
    "vimball",
    "vimballPlugin",
    "zip",
    "zipPlugin",
}

for _, plugin in pairs(disabled_built_ins) do
    vim.g["loaded_" .. plugin] = 1
end

vim.g.mapleader = " "
vim.g.maplocalleader = ","
vim.o.shell = "zsh"

vim.g.hardmode = 1
vim.g.vimtex_view_method = "zathura"
