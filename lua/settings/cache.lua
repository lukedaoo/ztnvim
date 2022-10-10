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

try_load_impatient()
