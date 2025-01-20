local ok, ts = pcall(require, "nvim-treesitter.configs")

if not ok then
    return
end

ts.setup {
    ensure_installed = { "c", "lua", "rust", "python", "java", "http", "json", "html" },
    sync_install = false,
    ignore_install = { "" }, -- List of parsers to ignore installing
    highlight = {
        enable = true,       -- false will disable the whole extension
        disable = { "" },    -- list of language that will be disabled
        additional_vim_regex_highlighting = true,
    },
    indent = { enable = true, disable = { "yaml" } },
}
