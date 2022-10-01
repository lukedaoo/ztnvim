local function try_load_impatient()
    _G.__luacache_config = {
        chunks = {
            enable = true,
            path = vim.fn.stdpath('config') .. '/.luacache_chunks',
        },
        modpaths = {
            enable = true,
            path = vim.fn.stdpath('config') .. '/.luacache_modpaths',
        }
    }
    local status_impatient, _ = pcall(require, "impatient")

    if status_impatient then
        vim.g.loaded_impatient = 1
    else
        vim.g.loaded_impatient = 0
    end
end

local function try_load_packer_cache()

    local ok, _ = pcall(require, "plugin.packer_compiled")
    if ok then
        return
    end
end

try_load_impatient()
try_load_packer_cache()
