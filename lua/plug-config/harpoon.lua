local status_ok, telescope = pcall(require, "telescope")
if not status_ok then
    return
end

local h_status_ok, harpoon = pcall(require, "harpoon")
if not h_status_ok then
    return
end
telescope.load_extension("harpoon")

local map = require("lib").map

local conf = require("telescope.config").values
local function toggle_telescope(harpoon_files)
    local file_paths = {}
    for _, item in ipairs(harpoon_files.items) do
        table.insert(file_paths, item.value)
    end

    require("telescope.pickers").new({}, {
        prompt_title = "Harpoon",
        finder = require("telescope.finders").new_table({
            results = file_paths,
        }),
        previewer = conf.file_previewer({}),
        sorter = conf.generic_sorter({}),
    }):find()
end

harpoon:setup()
-- REQUIRED
map("n", "<leader><Tab>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)

map("n", "mm", function() harpoon:list():add() end)
map("n", "mq", function() harpoon:list():select(1) end)
map("n", "mw", function() harpoon:list():select(2) end)
map("n", "me", function() harpoon:list():select(3) end)
map("n", "mr", function() harpoon:list():select(4) end)

-- Toggle previous & next buffers stored within Harpoon list
map("n", "mn", function() harpoon:list():prev() end)
map("n", "mp", function() harpoon:list():next() end)
map("n", "m;", function()
    toggle_telescope(harpoon:list())
end)
