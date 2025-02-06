local status_ok, image = pcall(require, "image")
if not status_ok then
    return
end
image.setup({
    max_width = 40,
    max_height = 40,
    -- max_width_window_percentage = nil,
    -- max_height_window_percentage = 50,
})
