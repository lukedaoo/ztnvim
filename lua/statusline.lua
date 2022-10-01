local utils = require("lib.core")
local symbol_config = utils.symbol_config
local colors = utils.statusline_colors

local function truncate_statusline(small)
    local limit = (small and utils.truncation_limit_s) or utils.truncation_limit
    return (utils.is_htruncated(limit) and
        vim.api.nvim_get_option_value('laststatus', { scope = 'global' }) ~= 3)
end

-- get the display name for current mode
local function get_current_mode()
    local current_mode = vim.api.nvim_get_mode().mode
    return string.format(' %s ', utils.modes[current_mode]):upper()
end

-- get git information of current file
-- NOTE(vir): release gitsigns dependencies?
local function get_git_status()
    local meta = {}
    local gitsigns_summary = vim.b.gitsigns_status_dict
    if not gitsigns_summary then return '' end

    meta['branch'] = gitsigns_summary['head']
    meta['added'] = gitsigns_summary['added']
    meta['modified'] = gitsigns_summary['changed']
    meta['removed'] = gitsigns_summary['removed']

    if truncate_statusline() then return string.format(' %s ', meta['branch']) end
    return string.format(' %s | +%s ~%s -%s ', meta['branch'], meta['added'], meta['modified'], meta['removed'])
end

-- get current tag name
local function get_tagname()
    local bufnr = vim.fn.bufnr('%')
    if utils.tag_state.context[bufnr] == nil or truncate_statusline(true) then return '' end

    return string.format("[ %s %s ] ", utils.tag_state.context[bufnr].icon, utils.tag_state.context[bufnr].name)
end

-- get current file name
local function get_filename()
    if truncate_statusline() then return ' %t ' end
    return ' %f '
end

-- get current line/col
local function get_line_col() return ' %l:%c ' end

-- get current percentage through file
local function get_percentage()
    if truncate_statusline() then return '' end
    return ' %p%% '
end

-- get current file type
local function get_filetype() return ' %y ' end

-- get buffer number
local function get_bufnr()
    if truncate_statusline(true) then return '' end
    return ' %n '
end

-- get current file diagnostics
local function get_diagnostics()
    if #vim.lsp.buf_get_clients(0) == 0 then return '' end

    local status_parts = {}
    local errors = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })

    if errors > 0 then
        table.insert(status_parts, symbol_config.indicator_error .. symbol_config.indicator_seperator .. errors)
    end

    if not truncate_statusline(true) then
        local warnings = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })
        local hints = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.HINT })
        local infos = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.INFO })

        if warnings > 0 then table.insert(status_parts,
                symbol_config.indicator_warning .. symbol_config.indicator_seperator .. warnings)
        end
        if infos > 0 then table.insert(status_parts,
                symbol_config.indicator_info .. symbol_config.indicator_seperator .. infos)
        end
        if hints > 0 then table.insert(status_parts,
                symbol_config.indicator_hint .. symbol_config.indicator_seperator .. hints)
        end
    end

    local status_diagnostics = vim.trim(table.concat(status_parts, ' '))
    if status_diagnostics ~= '' then return ' ' .. status_diagnostics .. ' ' end
    return ''
end

-- special statusline
local function statusline_special(mode)
    return colors.active .. ' ' .. mode .. ' ' .. colors.inactive
end

-- inactive statusline
local function statusline_inactive()
    local filename = colors.file .. get_filename()
    local line_col = colors.line_col .. get_line_col()
    local percentage = colors.percentage .. get_percentage()
    local filetype = colors.filetype .. get_filetype()

    return table.concat({
        colors.active, filename, colors.inactive,
        '%=% ',
        line_col, percentage, filetype, colors.inactive
    })
end

-- active statusline
local function statusline_normal()
    local mode = colors.mode .. get_current_mode()
    local git = colors.git .. get_git_status()
    local diagnostics = colors.diagnostics .. get_diagnostics()
    local truncator = '%<'
    local filename = colors.file .. get_filename()
    local tagname = colors.tagname .. get_tagname()
    local line_col = colors.line_col .. get_line_col()
    local percentage = colors.percentage .. get_percentage()
    local bufnr = colors.bufnr .. get_bufnr()
    local filetype = colors.filetype .. get_filetype()

    return table.concat({
        colors.active, mode, git, diagnostics, truncator, filename,
        colors.inactive, '%=% ', tagname, line_col, percentage, bufnr, filetype,
        colors.inactive
    })
end

-- generate statusline
StatusLine = function(mode)
    if mode then return statusline_special(mode) end
    return statusline_normal()
end

-- generate inactive statusline
StatusLineInactive = function() return statusline_inactive() end

-- NOTE(vir): consider moving to lua
vim.cmd [[
    let g:statusline_blacklist = ['diagnostics', 'qf', 'gitcommit', 'NvimTree',
                                \ 'DiffviewFiles', 'DiffviewFileHistory',
                                \ 'dapui_watches', 'dapui_stacks', 'dapui_scopes', 'dapui_breakpoints', 'dap-repl']
    augroup StatusLine
        autocmd!
        autocmd WinEnter,BufEnter * if index(statusline_blacklist, &ft) < 0 | setlocal statusline=%!v:lua.StatusLine() | endif
        autocmd WinLeave,BufLeave * if index(statusline_blacklist, &ft) < 0 | setlocal statusline=%!v:lua.StatusLineInactive() | endif
        autocmd FileType terminal setlocal statusline=%!v:lua.StatusLine('Terminal')
        autocmd BufWinEnter quickfix setlocal statusline=%!v:lua.StatusLine('QuickFix')
        autocmd BufWinEnter diagnostics setlocal statusline=%!v:lua.StatusLine('Diagnostics')
        autocmd BufWinEnter NvimTree_1 setlocal statusline=%!v:lua.StatusLine('Explorer')
        autocmd FileType gitc setlocal statusline=%!v:lua.StatusLine('GitCommit')
        autocmd FileType DiffviewFiles set statusline=%!v:lua.StatusLine('DiffViewFiles')
        autocmd FileType DiffviewFileHistory set statusline=%!v:lua.StatusLine('DiffViewFileHistory')
        " autocmd BufEnter \[dap-terminal\]* setlocal statusline=%!v:lua.StatusLine('Output')
        autocmd FileType dapui_watches setlocal statusline=%!v:lua.StatusLine('Watches')
        autocmd FileType dapui_stacks setlocal statusline=%!v:lua.StatusLine('Stacks')
        autocmd FileType dapui_scopes setlocal statusline=%!v:lua.StatusLine('Scopes')
        autocmd FileType dapui_breakpoints setlocal statusline=%!v:lua.StatusLine('Breaks')
        autocmd FileType dap-repl setlocal statusline=%!v:lua.StatusLine('Repl')
    augroup end
]]

return { StatusLine = StatusLine, StatusLineInactive = StatusLineInactive }
