local status_ok, jdtls = pcall(require, "jdtls")
if not status_ok then
    return
end

-- Determine OS
local home = os.getenv "HOME"
local workspace = "/.jdtls_workspace/"

if vim.fn.has "mac" == 1 then
    WORKSPACE_PATH = home .. workspace
    CONFIG = "mac"
elseif vim.fn.has "unix" == 1 then
    WORKSPACE_PATH = home .. workspace
    CONFIG = "linux"
else
    print "Unsupported system"
end

local mason_path = vim.fn.stdpath("data") .. "/mason/packages/jdtls"

local launcher_file_path = "/plugins/org.eclipse.equinox.launcher_*.jar";
local launcher_path = mason_path .. launcher_file_path

launcher_path = vim.fn.glob(launcher_path)

if #launcher_path == 0 then
    launcher_path = vim.fn.glob(launcher_path, 1, 1)[1]
end

local lombok_file_path = "/lombok.jar"
local lombok_path = mason_path .. lombok_file_path

local config_file_path = "/config_" .. CONFIG
local config_path = mason_path .. config_file_path

-- Find root of project
local root_markers = { ".git", "mvnw", "gradlew", "pom.xml", "build.gradle" }
local root_dir = require("jdtls.setup").find_root(root_markers)
if root_dir == "" then
    return
end

local extendedClientCapabilities = jdtls.extendedClientCapabilities
extendedClientCapabilities.resolveAdditionalTextEditsSupport = true

local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")

local workspace_dir = WORKSPACE_PATH .. project_name

JAVA_DAP_ACTIVE = true

local bundles = {}

if JAVA_DAP_ACTIVE then
    local java_debug = home ..
        "/.java-dap-tool/java-debug/com.microsoft.java.debug.plugin/target/com.microsoft.java.debug.plugin-*.jar"
    vim.list_extend(bundles, vim.split(vim.fn.glob(java_debug), "\n"))

    local vscode_java_test = home ..
        "/.java-dap-tool/vscode-java-test/server/*.jar"
    vim.list_extend(bundles, vim.split(vim.fn.glob(vscode_java_test), "\n"))
end

local lsp_config_status_ok, lsp_config = pcall(require, "lsp.default-config")
if not lsp_config_status_ok then
    print("Default config was not found")
    return
end

local on_attach = lsp_config.on_attach
local capabilities = lsp_config.capabilities

local config = {
    cmd = {
        "java",
        "-Declipse.application=org.eclipse.jdt.ls.core.id1",
        "-Dosgi.bundles.defaultStartLevel=4",
        "-Declipse.product=org.eclipse.jdt.ls.core.product",
        "-Dlog.protocol=true",
        "-Dlog.level=ALL",
        "-javaagent:" .. lombok_path,
        "-Xms1g",
        "--add-modules=ALL-SYSTEM",
        "--add-opens",
        "java.base/java.util=ALL-UNNAMED",
        "--add-opens",
        "java.base/java.lang=ALL-UNNAMED",
        "-jar",
        launcher_path,
        "-configuration",
        config_path,
        "-data",
        workspace_dir,
    },

    -- on_attach = on_detach,
    capabilities = capabilities,
    root_dir = root_dir,
    settings = {
        java = {
            -- jdt = {
            --   ls = {
            --     vmargs = "-XX:+UseParallelGC -XX:GCTimeRatio=4 -XX:AdaptiveSizePolicyWeight=90 -Dsun.zip.disableMemoryMapping=true -Xmx1G -Xms100m"
            --   }
            -- },
            eclipse = {
                downloadSources = true,
            },
            configuration = {
                updateBuildConfiguration = "interactive",
            },
            maven = {
                downloadSources = true,
            },
            implementationsCodeLens = {
                enabled = true,
            },
            referencesCodeLens = {
                enabled = true,
            },
            references = {
                includeDecompiledSources = true,
            },
            format = {
                enabled = true,
                settings = {
                    profile = "GoogleStyle",
                    url = home .. "/.code-formatter/.eclipse-java-google-formatter.xml",
                },
            },
        }, signatureHelp = { enabled = true },
        completion = {
            favoriteStaticMembers = {
                "org.hamcrest.MatcherAssert.assertThat",
                "org.hamcrest.Matchers.*",
                "org.hamcrest.CoreMatchers.*",
                "org.junit.jupiter.api.Assertions.*",
                "java.util.Objects.requireNonNull",
                "java.util.Objects.requireNonNullElse",
                "org.mockito.Mockito.*",
            },
        },
        contentProvider = { preferred = "fernflower" },
        extendedClientCapabilities = extendedClientCapabilities,
        sources = {
            organizeImports = {
                starThreshold = 9999,
                staticStarThreshold = 9999,
            },
        },
        codeGeneration = {
            toString = {
                template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}",
            },
            useBlocks = true,
        },
    },
    flags = {
        allow_incremental_sync = true,
        server_side_fuzzy_completion = true,
    },
    init_options = {
        bundles = bundles,
    },
}

config["on_attach"] = function(client, bufnr)
    require("jdtls.dap").setup_dap_main_class_configs()
    require("jdtls").setup_dap({ hotcodereplace = 'auto' })
    on_attach(client, bufnr)
end

jdtls.start_or_attach(config)

local map = require("lib.core").map;

map("i", ";;", "<ESC>A;");
