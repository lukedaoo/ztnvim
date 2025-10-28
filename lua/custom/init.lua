require("custom.floating-file").setup()

require("custom.quick-note").setup({
    global_dir = vim.g.notes_dir,
    note_name = "todo.norg"
})

require("custom.hardmode").setup()
require("custom.commands").setup()
require("custom.floating-ter").setup()
require("custom.run").setup()
