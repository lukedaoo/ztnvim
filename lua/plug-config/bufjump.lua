local ok, bufjump = pcall(require, "bufjump");

if not ok then
    return
end
bufjump.setup({
    forward = "<C-n>",
    backward = "<C-p>",
    on_success = nil
})
