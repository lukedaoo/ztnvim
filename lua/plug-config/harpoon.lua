local status_ok, telescope = pcall(require, "telescope")
if not status_ok then
    return
end

local h_status_ok, harpoon = pcall(require, "harpoon")
if not h_status_ok then
    return
end

telescope.load_extension("harpoon")

local map = require("lib.core").map

map("n", "mm", "<cmd>lua require('harpoon.mark').add_file()<CR>")
map("n", "m.", "<cmd>lua require('harpoon.ui').nav_next()<CR>")
map("n", "m,", "<cmd>lua require('harpoon.ui').nav_prev()<CR>")
map("n", "ms", "<cmd>Telescope harpoon marks<CR>")
map("n", "m;", "<cmd>lua require('harpoon.ui').toggle_quick_menu()<CR>")

map("n", "m1", "<cmd>lua require('harpoon.ui').nav_file(1)<CR>");
map("n", "m2", "<cmd>lua require('harpoon.ui').nav_file(2)<CR>");
map("n", "m3", "<cmd>lua require('harpoon.ui').nav_file(3)<CR>");
map("n", "m4", "<cmd>lua require('harpoon.ui').nav_file(4)<CR>");

map("n", "<Tab>", function()
    require('telescope').extensions.harpoon.marks(
        require('telescope.themes')
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
