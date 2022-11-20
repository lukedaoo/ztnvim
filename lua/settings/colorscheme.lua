local default_colorscheme = "oxocarbon"

local function load_colorscheme(colorscheme)
    local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
    if not status_ok then
        vim.notify("colorscheme " .. colorscheme .. " not found!")
        return
    end
end

local function load_ayu_colorscheme()
    local set_color_status, _ = pcall(vim.cmd, "let ayucolor='darker'");
    if set_color_status then
        load_colorscheme("ayu")
    end
end

local function load_onedark_colorscheme()
    local status_ok, onedark = pcall(require, "onedark")

    if status_ok then
        onedark.setup({ style = "darker" })
        onedark.load()
    end
end

local function load_carbon_colorscheme()
    load_colorscheme("oxocarbon")
end

if default_colorscheme == "ayu"
then
    load_ayu_colorscheme()
elseif default_colorscheme == "onedark"
then
    load_onedark_colorscheme()
elseif default_colorscheme == "oxocarbon"
then
    load_carbon_colorscheme()
else
    load_colorscheme(default_colorscheme)
end
