vim.cmd("hi clear")
if vim.fn.exists("syntax_on") == 1 then
    vim.cmd("syntax reset")
end
vim.o.termguicolors = true
vim.o.background = "dark"
vim.g.colors_name = "zod"

local c = {
    bg = "#000000",
    fg = "#e4e4e4",
    purple = "#b794f6",
    green = "#4ade80",
    -- from gruber-darker
    brown = "#cc8c3c",
    niagara = "#96a6c8",
    niagara_dark = "#2a2f45",
    quartz = "#95a99f",
    wisteria = "#9e95c7",
    yellow = "#ffdd33",
    red = "#f43841",
}

local hl = vim.api.nvim_set_hl

hl(0, "Normal", { fg = c.fg, bg = c.bg })
hl(0, "NormalFloat", { fg = c.fg, bg = c.bg })
hl(0, "SignColumn", { bg = c.bg })
hl(0, "EndOfBuffer", { fg = c.bg, bg = c.bg })
hl(0, "Visual", { bg = c.niagara_dark })
hl(0, "CursorLine", { bg = "#17171f" })

hl(0, "Comment", { fg = c.brown })
hl(0, "Keyword", { fg = c.purple })
hl(0, "Statement", { link = "Keyword" })
hl(0, "String", { fg = c.green })
hl(0, "Function", { fg = c.fg })
hl(0, "Type", { fg = c.purple })
hl(0, "Constant", { fg = c.quartz })
hl(0, "Number", { fg = c.purple })
hl(0, "PreProc", { fg = c.quartz })
hl(0, "Todo", { fg = c.yellow, bold = true })
hl(0, "Error", { fg = c.red })

hl(0, "@keyword", { link = "Keyword" })
hl(0, "@keyword.return", { fg = c.green })
hl(0, "Special", { fg = c.fg })
hl(0, "@string", { link = "String" })
hl(0, "@function", { link = "Function" })
hl(0, "@type", { link = "Type" })
hl(0, "@constant", { link = "Constant" })
hl(0, "@number", { link = "Number" })
hl(0, "@comment", { link = "Comment" })

hl(0, "DiagnosticError", { fg = c.red })
hl(0, "DiagnosticWarn", { fg = c.yellow })

-- treesitter
local link = function(from, to)
    hl(0, from, { link = to })
end

for _, g in ipairs({
    "@keyword.type", "@keyword.modifier", "@keyword.function", "@keyword.operator",
    "@keyword.conditional", "@keyword.repeat", "@keyword.import", "@keyword.exception",
    "@keyword.directive", "@keyword.storage", "@storageclass", "@include", "@conditional", "@repeat",
}) do
    link(g, "Keyword")
end

for _, g in ipairs({ "@type.builtin", "@type.definition", "@type.qualifier", "@constant.builtin", "@boolean", "@number.float" }) do
    link(g, "Type")
end

link("@string.escape", "Number")
link("@character", "String")
link("@function.builtin", "Function")
link("@function.call", "Function")
link("@function.method", "Function")
link("@function.method.call", "Function")
link("@constructor", "Type")
link("@variable", "Normal")
link("@variable.parameter", "Normal")
hl(0, "@variable.member", { link = "Normal" })
hl(0, "@property", { link = "Normal" })
hl(0, "@variable.builtin", { fg = c.purple, italic = true })
hl(0, "@module", { fg = c.quartz })
hl(0, "@attribute", { fg = c.quartz })
hl(0, "@punctuation", { fg = c.fg })
hl(0, "@operator", { fg = c.fg })
hl(0, "@punctuation.special", { fg = c.fg })
hl(0, "Operator", { fg = c.fg })
hl(0, "Delimiter", { fg = c.fg })
hl(0, "Identifier", { fg = c.fg })
hl(0, "@lsp.type.variable", {})
hl(0, "@lsp.type.property", { link = "@property" })
hl(0, "@lsp.type.class", { link = "Type" })
hl(0, "@lsp.type.struct", { link = "Type" })
hl(0, "@lsp.type.enum", { link = "Type" })
hl(0, "@lsp.type.namespace", { link = "@module" })
hl(0, "@lsp.type.typeParameter", { link = "Type" })

for _, g in ipairs({ "@keyword.modifier", "@type.qualifier", "@storageclass" }) do
    hl(0, g, { fg = c.purple, bold = true })
end

-- nvim-tree
for _, g in ipairs({
    "NvimTreeFolderName", "NvimTreeOpenedFolderName", "NvimTreeEmptyFolderName",
    "NvimTreeFolderIcon", "NvimTreeRootFolder",
}) do
    hl(0, g, { fg = c.niagara, bold = true })
end

-- line numbers
hl(0, "LineNr", { fg = "#52494e" })
hl(0, "CursorLineNr", { fg = c.yellow })

-- window separators
hl(0, "WinSeparator", { fg = "#453d41", bg = c.bg })
hl(0, "VertSplit", { link = "WinSeparator" })
hl(0, "NvimTreeWinSeparator", { link = "WinSeparator" })

-- html: purple tag brackets
for _, g in ipairs({ "htmlTag", "htmlEndTag", "@tag.delimiter", "@punctuation.bracket.html" }) do
    hl(0, g, { fg = c.purple })
end
hl(0, "htmlComment", { link = "Comment" })
hl(0, "htmlCommentPart", { link = "Comment" })

-- `return` green where treesitter is absent (regex syntax, LSP tokens)
hl(0, "ZodReturn", { fg = c.green })
local group = vim.api.nvim_create_augroup("ZodReturn", { clear = true })
local RETURN_FILETYPES = { "java", "go", "rust", "javascript", "sh", "bash", "html" }

local function syntax_return(buf)
    if vim.treesitter.highlighter.active[buf] then
        return
    end
    vim.api.nvim_buf_call(buf, function()
        vim.cmd("syntax keyword ZodReturn return containedin=ALLBUT,.*String.*,.*Comment.*")
    end)
end

vim.api.nvim_create_autocmd("Syntax", {
    group = group,
    pattern = RETURN_FILETYPES,
    callback = function(args)
        syntax_return(args.buf)
    end,
})

vim.api.nvim_create_autocmd("LspTokenUpdate", {
    group = group,
    callback = function(args)
        local token = args.data.token
        if token.type ~= "keyword" then
            return
        end
        local text = vim.api.nvim_buf_get_text(
            args.buf, token.line, token.start_col, token.line, token.end_col, {}
        )[1]
        if text ~= "return" then
            return
        end
        vim.lsp.semantic_tokens.highlight_token(token, args.buf, args.data.client_id, "ZodReturn")
    end,
})

for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if vim.api.nvim_buf_is_loaded(buf) and vim.tbl_contains(RETURN_FILETYPES, vim.bo[buf].filetype) then
        syntax_return(buf)
    end
end
