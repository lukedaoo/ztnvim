vim.opt.conceallevel = 0

vim.cmd [[
  let g:vimtex_quickfix_ignore_filters = [
  \'Underfull',
  \'Overfull',
  \'LaTeX Font Warning'
  \]
  let g:Tex_IgnoreLevel = 8
]]

vim.keymap.set("n", "<leader>vc", ":VimtexCompile<cr>")
vim.keymap.set("n", "<leader>vv", ":VimtexView<cr>")

vim.keymap.set("i", "sqrt<tab>", '\\sqrt{')
vim.keymap.set("i", "int<tab>", '\\int_a^b')
vim.keymap.set("i", "limit<tab>", '\\lim_{x\\to\\infty}')
vim.keymap.set("i", "frac<tab>", '\\frac{')
