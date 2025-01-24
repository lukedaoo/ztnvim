local status_ok, telescope = pcall(require, "telescope")
if not status_ok then
    return
end

local h_status_ok, _ = pcall(require, "harpoon")
if not h_status_ok then
    return
end

telescope.load_extension("harpoon")

local map = require("lib").map

map("n", "mm", "<cmd>lua require('harpoon.mark').add_file()<CR>")
map("n", "mn", "<cmd>lua require('harpoon.ui').nav_next()<CR>")
map("n", "mp", "<cmd>lua require('harpoon.ui').nav_prev()<CR>")
map("n", "ms", "<cmd>Telescope harpoon marks<CR>")
map("n", "m;", "<cmd>lua require('harpoon.ui').toggle_quick_menu()<CR>")

map("n", "mq", "<cmd>lua require('harpoon.ui').nav_file(1)<CR>")
map("n", "mw", "<cmd>lua require('harpoon.ui').nav_file(2)<CR>")
map("n", "me", "<cmd>lua require('harpoon.ui').nav_file(3)<CR>")
map("n", "mr", "<cmd>lua require('harpoon.ui').nav_file(4)<CR>")

map("n", "<leader><Tab>", function()
    require("telescope").extensions.harpoon.marks(
        require("telescope.themes")
        .get_dropdown {
            previewer = false,
            initial_mode = 'normal',
            prompt_title = 'Harpoon'
        })
end)

map("n", "<S-Tab>", function()
    require('telescope.builtin').buffers(
        require('telescope.themes')
        .get_dropdown {
            previewer = false,
            initial_mode = 'normal'
        })
end)
