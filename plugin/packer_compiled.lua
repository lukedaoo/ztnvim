-- Automatically generated packer.nvim plugin loader code

if vim.api.nvim_call_function('has', {'nvim-0.5'}) ~= 1 then
  vim.api.nvim_command('echohl WarningMsg | echom "Invalid Neovim version for packer.nvim! | echohl None"')
  return
end

vim.api.nvim_command('packadd packer.nvim')

local no_errors, error_msg = pcall(function()

_G._packer = _G._packer or {}
_G._packer.inside_compile = true

local time
local profile_info
local should_profile = false
if should_profile then
  local hrtime = vim.loop.hrtime
  profile_info = {}
  time = function(chunk, start)
    if start then
      profile_info[chunk] = hrtime()
    else
      profile_info[chunk] = (hrtime() - profile_info[chunk]) / 1e6
    end
  end
else
  time = function(chunk, start) end
end

local function save_profiles(threshold)
  local sorted_times = {}
  for chunk_name, time_taken in pairs(profile_info) do
    sorted_times[#sorted_times + 1] = {chunk_name, time_taken}
  end
  table.sort(sorted_times, function(a, b) return a[2] > b[2] end)
  local results = {}
  for i, elem in ipairs(sorted_times) do
    if not threshold or threshold and elem[2] > threshold then
      results[i] = elem[1] .. ' took ' .. elem[2] .. 'ms'
    end
  end
  if threshold then
    table.insert(results, '(Only showing plugins that took longer than ' .. threshold .. ' ms ' .. 'to load)')
  end

  _G._packer.profile_output = results
end

time([[Luarocks path setup]], true)
local package_path_str = "/home/luked/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?.lua;/home/luked/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?/init.lua;/home/luked/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?.lua;/home/luked/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?/init.lua"
local install_cpath_pattern = "/home/luked/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/lua/5.1/?.so"
if not string.find(package.path, package_path_str, 1, true) then
  package.path = package.path .. ';' .. package_path_str
end

if not string.find(package.cpath, install_cpath_pattern, 1, true) then
  package.cpath = package.cpath .. ';' .. install_cpath_pattern
end

time([[Luarocks path setup]], false)
time([[try_loadstring definition]], true)
local function try_loadstring(s, component, name)
  local success, result = pcall(loadstring(s), name, _G.packer_plugins[name])
  if not success then
    vim.schedule(function()
      vim.api.nvim_notify('packer.nvim: Error running ' .. component .. ' for ' .. name .. ': ' .. result, vim.log.levels.ERROR, {})
    end)
  end
  return result
end

time([[try_loadstring definition]], false)
time([[Defining packer_plugins]], true)
_G.packer_plugins = {
  ["Comment.nvim"] = {
    config = { "require('plug-config/comment')" },
    loaded = true,
    path = "/home/luked/.local/share/nvim/site/pack/packer/start/Comment.nvim",
    url = "https://github.com/numToStr/Comment.nvim"
  },
  LuaSnip = {
    loaded = true,
    path = "/home/luked/.local/share/nvim/site/pack/packer/start/LuaSnip",
    url = "https://github.com/L3MON4D3/LuaSnip"
  },
  ["ayu-vim-darker"] = {
    loaded = true,
    path = "/home/luked/.local/share/nvim/site/pack/packer/start/ayu-vim-darker",
    url = "https://github.com/k4yt3x/ayu-vim-darker"
  },
  ["bufdelete.nvim"] = {
    loaded = true,
    path = "/home/luked/.local/share/nvim/site/pack/packer/start/bufdelete.nvim",
    url = "https://github.com/famiu/bufdelete.nvim"
  },
  ["bufjump.nvim"] = {
    config = { "\27LJ\2\nY\0\0\3\0\4\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0B\0\2\1K\0\1\0\1\0\2\rbackward\n<C-o>\fforward\n<C-i>\nsetup\fbufjump\frequire\0" },
    loaded = true,
    path = "/home/luked/.local/share/nvim/site/pack/packer/start/bufjump.nvim",
    url = "https://github.com/kwkarlwang/bufjump.nvim"
  },
  ["cmp-buffer"] = {
    loaded = true,
    path = "/home/luked/.local/share/nvim/site/pack/packer/start/cmp-buffer",
    url = "https://github.com/hrsh7th/cmp-buffer"
  },
  ["cmp-nvim-lsp"] = {
    loaded = true,
    path = "/home/luked/.local/share/nvim/site/pack/packer/start/cmp-nvim-lsp",
    url = "https://github.com/hrsh7th/cmp-nvim-lsp"
  },
  ["cmp-path"] = {
    after_files = { "/home/luked/.local/share/nvim/site/pack/packer/opt/cmp-path/after/plugin/cmp_path.lua" },
    load_after = {},
    loaded = true,
    needs_bufread = false,
    path = "/home/luked/.local/share/nvim/site/pack/packer/opt/cmp-path",
    url = "https://github.com/hrsh7th/cmp-path"
  },
  cmp_luasnip = {
    after_files = { "/home/luked/.local/share/nvim/site/pack/packer/opt/cmp_luasnip/after/plugin/cmp_luasnip.lua" },
    load_after = {},
    loaded = true,
    needs_bufread = false,
    path = "/home/luked/.local/share/nvim/site/pack/packer/opt/cmp_luasnip",
    url = "https://github.com/saadparwaiz1/cmp_luasnip"
  },
  ["friendly-snippets"] = {
    loaded = true,
    path = "/home/luked/.local/share/nvim/site/pack/packer/start/friendly-snippets",
    url = "https://github.com/rafamadriz/friendly-snippets"
  },
  ["gitsigns.nvim"] = {
    config = { "require('gitsigns').setup({})" },
    loaded = true,
    path = "/home/luked/.local/share/nvim/site/pack/packer/start/gitsigns.nvim",
    url = "https://github.com/lewis6991/gitsigns.nvim"
  },
  harpoon = {
    config = { "require('plug-config/harpoon')" },
    load_after = {},
    loaded = true,
    needs_bufread = false,
    path = "/home/luked/.local/share/nvim/site/pack/packer/opt/harpoon",
    url = "https://github.com/ThePrimeagen/harpoon"
  },
  ["impatient.nvim"] = {
    loaded = true,
    path = "/home/luked/.local/share/nvim/site/pack/packer/start/impatient.nvim",
    url = "https://github.com/lewis6991/impatient.nvim"
  },
  ["luatab.nvim"] = {
    config = { "require('luatab').setup({})" },
    loaded = true,
    path = "/home/luked/.local/share/nvim/site/pack/packer/start/luatab.nvim",
    url = "https://github.com/alvarosevilla95/luatab.nvim"
  },
  ["mason-lspconfig.nvim"] = {
    loaded = true,
    path = "/home/luked/.local/share/nvim/site/pack/packer/start/mason-lspconfig.nvim",
    url = "https://github.com/williamboman/mason-lspconfig.nvim"
  },
  ["mason.nvim"] = {
    config = { "require('plug-config/lsp')" },
    load_after = {},
    loaded = true,
    needs_bufread = false,
    path = "/home/luked/.local/share/nvim/site/pack/packer/opt/mason.nvim",
    url = "https://github.com/williamboman/mason.nvim"
  },
  ["nvim-cmp"] = {
    after = { "cmp-path", "cmp_luasnip" },
    config = { "require('plug-config/cmp')" },
    load_after = {},
    loaded = true,
    needs_bufread = false,
    path = "/home/luked/.local/share/nvim/site/pack/packer/opt/nvim-cmp",
    url = "https://github.com/hrsh7th/nvim-cmp"
  },
  ["nvim-dap"] = {
    config = { "require('plug-config/dap')" },
    load_after = {
      ["nvim-dap-ui"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/home/luked/.local/share/nvim/site/pack/packer/opt/nvim-dap",
    url = "https://github.com/mfussenegger/nvim-dap"
  },
  ["nvim-dap-ui"] = {
    after = { "nvim-dap" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/luked/.local/share/nvim/site/pack/packer/opt/nvim-dap-ui",
    url = "https://github.com/rcarriga/nvim-dap-ui"
  },
  ["nvim-jdtls"] = {
    loaded = true,
    path = "/home/luked/.local/share/nvim/site/pack/packer/start/nvim-jdtls",
    url = "https://github.com/mfussenegger/nvim-jdtls"
  },
  ["nvim-lspconfig"] = {
    loaded = true,
    path = "/home/luked/.local/share/nvim/site/pack/packer/start/nvim-lspconfig",
    url = "https://github.com/neovim/nvim-lspconfig"
  },
  ["nvim-tree.lua"] = {
    config = { "require('plug-config/nvimtree')" },
    loaded = true,
    path = "/home/luked/.local/share/nvim/site/pack/packer/start/nvim-tree.lua",
    url = "https://github.com/kyazdani42/nvim-tree.lua"
  },
  ["nvim-treesitter"] = {
    config = { "require('plug-config/treesitter')" },
    loaded = true,
    path = "/home/luked/.local/share/nvim/site/pack/packer/start/nvim-treesitter",
    url = "https://github.com/nvim-treesitter/nvim-treesitter"
  },
  ["nvim-web-devicons"] = {
    loaded = true,
    path = "/home/luked/.local/share/nvim/site/pack/packer/start/nvim-web-devicons",
    url = "https://github.com/kyazdani42/nvim-web-devicons"
  },
  ["onedark.nvim"] = {
    loaded = true,
    path = "/home/luked/.local/share/nvim/site/pack/packer/start/onedark.nvim",
    url = "https://github.com/navarasu/onedark.nvim"
  },
  ["packer.nvim"] = {
    loaded = true,
    path = "/home/luked/.local/share/nvim/site/pack/packer/start/packer.nvim",
    url = "https://github.com/wbthomason/packer.nvim"
  },
  ["plenary.nvim"] = {
    loaded = true,
    path = "/home/luked/.local/share/nvim/site/pack/packer/start/plenary.nvim",
    url = "https://github.com/nvim-lua/plenary.nvim"
  },
  ["popup.nvim"] = {
    loaded = true,
    path = "/home/luked/.local/share/nvim/site/pack/packer/start/popup.nvim",
    url = "https://github.com/nvim-lua/popup.nvim"
  },
  ["telescope.nvim"] = {
    after = { "harpoon" },
    config = { "require('plug-config/telescope')" },
    loaded = true,
    only_config = true,
    path = "/home/luked/.local/share/nvim/site/pack/packer/start/telescope.nvim",
    url = "https://github.com/nvim-telescope/telescope.nvim"
  },
  ["tokyonight.nvim"] = {
    loaded = true,
    path = "/home/luked/.local/share/nvim/site/pack/packer/start/tokyonight.nvim",
    url = "https://github.com/folke/tokyonight.nvim"
  },
  ["zen-mode.nvim"] = {
    config = { "require('plug-config/zen')" },
    loaded = true,
    path = "/home/luked/.local/share/nvim/site/pack/packer/start/zen-mode.nvim",
    url = "https://github.com/folke/zen-mode.nvim"
  }
}

time([[Defining packer_plugins]], false)
-- Config for: luatab.nvim
time([[Config for luatab.nvim]], true)
require('luatab').setup({})
time([[Config for luatab.nvim]], false)
-- Config for: telescope.nvim
time([[Config for telescope.nvim]], true)
require('plug-config/telescope')
time([[Config for telescope.nvim]], false)
-- Config for: Comment.nvim
time([[Config for Comment.nvim]], true)
require('plug-config/comment')
time([[Config for Comment.nvim]], false)
-- Config for: zen-mode.nvim
time([[Config for zen-mode.nvim]], true)
require('plug-config/zen')
time([[Config for zen-mode.nvim]], false)
-- Config for: nvim-tree.lua
time([[Config for nvim-tree.lua]], true)
require('plug-config/nvimtree')
time([[Config for nvim-tree.lua]], false)
-- Config for: gitsigns.nvim
time([[Config for gitsigns.nvim]], true)
require('gitsigns').setup({})
time([[Config for gitsigns.nvim]], false)
-- Config for: bufjump.nvim
time([[Config for bufjump.nvim]], true)
try_loadstring("\27LJ\2\nY\0\0\3\0\4\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0B\0\2\1K\0\1\0\1\0\2\rbackward\n<C-o>\fforward\n<C-i>\nsetup\fbufjump\frequire\0", "config", "bufjump.nvim")
time([[Config for bufjump.nvim]], false)
-- Config for: nvim-treesitter
time([[Config for nvim-treesitter]], true)
require('plug-config/treesitter')
time([[Config for nvim-treesitter]], false)
-- Load plugins in order defined by `after`
time([[Sequenced loading]], true)
vim.cmd [[ packadd LuaSnip ]]
vim.cmd [[ packadd harpoon ]]

-- Config for: harpoon
require('plug-config/harpoon')

vim.cmd [[ packadd cmp-nvim-lsp ]]
vim.cmd [[ packadd mason.nvim ]]

-- Config for: mason.nvim
require('plug-config/lsp')

vim.cmd [[ packadd nvim-cmp ]]

-- Config for: nvim-cmp
require('plug-config/cmp')

vim.cmd [[ packadd cmp-path ]]
vim.cmd [[ packadd cmp_luasnip ]]
time([[Sequenced loading]], false)
vim.cmd [[augroup packer_load_aucmds]]
vim.cmd [[au!]]
  -- Filetype lazy-loads
time([[Defining lazy-load filetype autocommands]], true)
vim.cmd [[au FileType lua ++once lua require("packer.load")({'nvim-dap-ui'}, { ft = "lua" }, _G.packer_plugins)]]
vim.cmd [[au FileType java ++once lua require("packer.load")({'nvim-dap-ui'}, { ft = "java" }, _G.packer_plugins)]]
vim.cmd [[au FileType python ++once lua require("packer.load")({'nvim-dap-ui'}, { ft = "python" }, _G.packer_plugins)]]
time([[Defining lazy-load filetype autocommands]], false)
vim.cmd("augroup END")

_G._packer.inside_compile = false
if _G._packer.needs_bufread == true then
  vim.cmd("doautocmd BufRead")
end
_G._packer.needs_bufread = false

if should_profile then save_profiles() end

end)

if not no_errors then
  error_msg = error_msg:gsub('"', '\\"')
  vim.api.nvim_command('echohl ErrorMsg | echom "Error in packer_compiled: '..error_msg..'" | echom "Please check your config for correctness" | echohl None')
end
