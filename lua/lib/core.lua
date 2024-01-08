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

return {
    map = map,
    get_username = get_username,
    get_homedir = get_homedir,
    get_os = get_os,
    get_terminal = get_terminal
}
