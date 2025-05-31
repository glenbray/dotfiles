local home = os.getenv('HOME')
local jdtls = require('jdtls')

-- Find root of project
local root_markers = {'gradlew', '.git', 'mvnw', 'pom.xml', 'build.gradle'}
local root_dir = require('jdtls.setup').find_root(root_markers)

-- eclipse.jdt.ls stores project specific data within a folder. If you are working
-- with multiple different projects, each project must use a dedicated data directory.
-- This variable is used to configure eclipse to use the directory name of the
-- current project found using the root_marker as the folder for project specific data.
local workspace_folder = home .. "/.local/share/eclipse/" .. vim.fn.fnamemodify(root_dir, ":p:h:t")

-- Helper function to extend or override a config table, similar to the way
-- that Plugin.setup() calls allow you to set options.
local function extend_or_override(config, custom, ...)
  if type(custom) == "function" then
    config = custom(config, ...) or config
  elseif custom then
    config = vim.tbl_deep_extend("force", config, custom) --[[@as table]]
  end
  return config
end

-- Determine OS
local os_config = "linux"
if vim.fn.has("mac") == 1 then
  os_config = "mac"
elseif vim.fn.has("win32") == 1 then
  os_config = "win"
end

-- Use Homebrew jdtls installation
local jdtls_path = "/opt/homebrew/opt/jdtls/libexec"
local launcher_jar = vim.fn.glob(jdtls_path .. "/plugins/org.eclipse.equinox.launcher_*.jar")
local config_dir = jdtls_path .. "/config_" .. os_config

if launcher_jar == "" then
  vim.notify("jdtls launcher jar not found at " .. jdtls_path, vim.log.levels.ERROR)
  return
end

local config = {
  cmd = {
    'java',
    '-Declipse.application=org.eclipse.jdt.ls.core.id1',
    '-Dosgi.bundles.defaultStartLevel=4',
    '-Declipse.product=org.eclipse.jdt.ls.core.product',
    '-Dlog.protocol=true',
    '-Dlog.level=ALL',
    '-Xmx1g',
    '--add-modules=ALL-SYSTEM',
    '--add-opens', 'java.base/java.util=ALL-UNNAMED',
    '--add-opens', 'java.base/java.lang=ALL-UNNAMED',
    '-jar', launcher_jar,
    '-configuration', config_dir,
    '-data', workspace_folder,
  },
  root_dir = root_dir,

  -- Here you can configure eclipse.jdt.ls specific settings
  -- See https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
  -- for a list of options
  settings = {
    java = {
      home = '/opt/homebrew/opt/openjdk',
      eclipse = {
        downloadSources = true,
      },
      configuration = {
        updateBuildConfiguration = "interactive",
        runtimes = {
          {
            name = "JavaSE-21",
            path = "/opt/homebrew/opt/openjdk@21",
          },
          {
            name = "JavaSE-22",
            path = "/opt/homebrew/opt/openjdk@22",
          },
          {
            name = "JavaSE-23",
            path = "/opt/homebrew/opt/openjdk@23",
          },
        }
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
          url = vim.fn.stdpath "config" .. "/lang-servers/intellij-java-google-style.xml",
          profile = "GoogleStyle",
        },
      },
    },
    signatureHelp = { enabled = true },
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
      importOrder = {
        "java",
        "javax",
        "com",
        "org"
      },
    },
    extendedClientCapabilities = jdtls.extendedClientCapabilities,
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
  },

  on_attach = function(client, bufnr)
    -- Enable completion triggered by <c-x><c-o>
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- Setup DAP
    jdtls.setup_dap({ hotcodereplace = 'auto' })
    require("jdtls.dap").setup_dap_main_class_configs()

    -- Add jdtls commands
    require("jdtls.setup").add_commands()

    -- Java specific keymaps
    local opts = { noremap=true, silent=true, buffer=bufnr }
    vim.keymap.set('n', '<A-o>', "<Cmd>lua require'jdtls'.organize_imports()<CR>", opts)
    vim.keymap.set('n', 'crv', "<Cmd>lua require'jdtls'.extract_variable()<CR>", opts)
    vim.keymap.set('v', 'crv', "<Esc><Cmd>lua require'jdtls'.extract_variable(true)<CR>", opts)
    vim.keymap.set('n', 'crc', "<Cmd>lua require'jdtls'.extract_constant()<CR>", opts)
    vim.keymap.set('v', 'crc', "<Esc><Cmd>lua require'jdtls'.extract_constant(true)<CR>", opts)
    vim.keymap.set('v', 'crm', "<Esc><Cmd>lua require'jdtls'.extract_method(true)<CR>", opts)
    vim.keymap.set('n', '<leader>df', "<Cmd>lua require'jdtls'.test_class()<CR>", opts)
    vim.keymap.set('n', '<leader>dn', "<Cmd>lua require'jdtls'.test_nearest_method()<CR>", opts)
  end,

  -- Language server `initializationOptions`
  -- You need to extend the `bundles` with paths to jar files
  -- if you want to use additional eclipse.jdt.ls plugins.
  --
  -- See https://github.com/mfussenegger/nvim-jdtls#java-debug-installation
  --
  -- If you don't plan on using the debugger or other eclipse.jdt.ls plugins you can remove this
  init_options = {
    bundles = {}
  },
}

-- This starts a new client & server,
-- or attaches to an existing client & server depending on the `root_dir`.
jdtls.start_or_attach(config)