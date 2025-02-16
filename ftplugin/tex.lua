vim.opt.conceallevel = 0

vim.cmd [[
  let g:vimtex_quickfix_ignore_filters = [
  \'Underfull',
  \'Overfull',
  \'LaTeX Font Warning'
  \]
  let g:Tex_IgnoreLevel = 8
]]

local map = require("lib").map;

map("n", "<leader>vc", ":VimtexCompile<cr>")
map("n", "<leader>vv", ":VimtexView<cr>")

map("i", "sqrt<tab>", '\\sqrt{');
map("i", "int<tab>", '\\int_a^b');
map("i", "limit<tab>", '\\lim_{x\\to\\infty}');
map("i", "frac<tab>", '\\frac{');
