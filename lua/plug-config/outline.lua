require("outline").setup {
    outline_items = {
        auto_set_cursor = false,        -- Disable auto cursor sync to code position
        highlight_hovered_item = false, -- Disable auto highlight of current/hovered symbol
        auto_update_events = {
            follow = {},                -- Disable auto-follow on CursorMoved etc.
        },
    },

    -- Keep your existing settings
    keymaps = {
        peek_location = "<Tab>",
    },
    symbol_folding = {
        autofold_depth = 1,
    },
}
