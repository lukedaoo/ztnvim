local function map(mode, lhs, rhs, opts, bufnr)
    local options = { noremap = true }
    if opts then options = vim.tbl_extend("force", options, opts) end
    if bufnr then options["buffer"] = bufnr end
    vim.keymap.set(mode, lhs, rhs, options)
end

-- get username ($USER)
local function get_username()
    return os.getenv('USER')
end

-- get home dir ($HOME)
local function get_homedir()
    return os.getenv('HOME')
end

-- get default terminal
local function get_terminal()
    local terminal = os.getenv('TERMINAL');
    if terminal == nil or terminal == '' then
        terminal = os.getenv('TERM')
    end
    return terminal
end

-- get operating system name
local function get_os()
    if vim.fn.has "mac" == 1 then
        return "mac"
    elseif vim.fn.has "unix" == 1 then
        return "unix"
    else
        return nil
    end
end

-- is buffer horizontally truncated
local function is_htruncated(width)
    local current_width = vim.api.nvim_win_get_width(0)
    return current_width < width
end

-- is buffer vertical truncated
local function is_vtruncated(height)
    local current_height = vim.api.nvim_win_get_height(0)
    return current_height < height
end

local tag_state = {
    cache = {},
    context = {},
    req_state = {}
}

return {
    tag_state = tag_state,
    truncation_limit_s = 80,
    truncation_limit = 120,
    truncation_limit_l = 160,
    is_htruncated = is_htruncated,
    is_vtruncated = is_vtruncated,
    symbol_config = {
        -- indicators, icons
        indicator_seperator = "",
        indicator_hint = "[@]",
        indicator_info = "[i]",
        indicator_warning = "[!]",
        indicator_error = "[x]",

        -- signs
        sign_hint = "@",
        sign_info = "i",
        sign_warning = "!",
        sign_error = "x",
    },
    modes = {
        ["n"]  = "Normal",
        ["no"] = "N-Pending",
        ["v"]  = "Visual",
        ["V"]  = "V-Line",
        ["S"]  = "S-Line",
        [""]   = "S-Block",
        ["i"]  = "Insert",
        ["ic"] = "Insert",
        ["R"]  = "Replace",
        ["Rv"] = "V-Replace",
        ["c"]  = "Command",
        ["cv"] = "Vim-Ex ",
        ["ce"] = "Ex",
        ["r"]  = "Prompt",
        ["rm"] = "More",
        ["r?"] = "Confirm",
        ["!"]  = "Shell",
        ["t"]  = "Terminal",
    },
    statusline_colors = {
        active      = "%#StatusLine#",
        inactive    = "%#StatusLineNC#",
        mode        = "%#PmenuSel#",
        git         = "%#Pmenu#",
        diagnostics = "%#PmenuSbar#",
        file        = "%#CursorLine#",
        tagname     = "%#PmenuSbar#",
        line_col    = "%#CursorLine#",
        percentage  = "%#CursorLine#",
        bufnr       = "%#PmenuSbar#",
        filetype    = "%#PmenuSel#",
    },
    map = map,
    get_username = get_username,
    get_homedir = get_homedir,
    get_os = get_os,
    get_terminal = get_terminal
}
