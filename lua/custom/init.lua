require("custom.floating-file").setup()

require("custom.quick-note").setup({
    global_dir = vim.g.notes_dir,
    note_name = "todo.norg"
})

require("custom.hardmode").setup()
require("custom.commands").setup()
require("custom.floating-ter").setup()
require("custom.run").setup({
    bookmarks = {
        cpp = "g++ *.cpp -o main && ./main",
        python = "python3 main.py",
        rust = "cargo run",
        test = "npm test",
        npm_build = "npm run build",
        npm_start = "npm run start",
        build = "make",
        clean = "make clean",
        server = "python3 -m http.server 8000",
    }
})
