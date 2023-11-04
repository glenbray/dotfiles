-- local root_markers =
local root_dir = require('jdtls.setup').find_root({'pom.xml', 'mvnw', '.git'})
local home = os.getenv('HOME')
local workspace_folder = home .. "/.local/share/eclipse/" .. vim.fn.fnamemodify(root_dir, ":p:h:t")

-- root_dir = vim.fs.dirname(vim.fs.find({'gradlew', '.git', 'mvnw'}, { upward = true })[1]),

local bundles = {
  vim.fn.glob(home .. "/Documents/projects/git/java-debug/com.microsoft.java.debug.plugin/target/com.microsoft.java.debug.plugin-*.jar", 1)
};

vim.list_extend(bundles, vim.split(vim.fn.glob(home .. "/Documents/projects/git/vscode-java-test/server/*.jar", 1), "\n"))

local lsp_attach = function(client, bufnr)
  -- mappings here
  require('jdtls').setup_dap({ hotcodereplace = 'auto' })
  require("jdtls.dap").setup_dap_main_class_configs() -- discover main class
  require("jdtls.setup").add_commands() -- not related to debugging but you probably want this
  require('dap.ext.vscode').load_launchjs()
end

local config = {
  root_dir = root_dir,
  cmd = {
    home .. '/.sdkman/candidates/java/current/bin/java',
    '-Declipse.application=org.eclipse.jdt.ls.core.id1',
    '-Dosgi.bundles.defaultStartLevel=4',
    '-Declipse.product=org.eclipse.jdt.ls.core.product',
    '-Dlog.protocol=true',
    '-Dlog.level=ALL',
    '-Xmx4g',
    '--add-modules=ALL-SYSTEM',
    '--add-opens', 'java.base/java.util=ALL-UNNAMED',
    '--add-opens', 'java.base/java.lang=ALL-UNNAMED',

    -- The jar file is located where jdtls was installed. This will need to be updated
    -- to the location where you installed jdtls
    '-jar', vim.fn.glob('/opt/homebrew/Cellar/jdtls/1.*.*/libexec/plugins/org.eclipse.equinox.launcher_*.jar'),

    -- The configuration for jdtls is also placed where jdtls was installed. This will
    -- need to be updated depending on your environment
    '-configuration', vim.fn.glob('/opt/homebrew/Cellar/jdtls/1.*.*/libexec/config_mac'),

    -- Use the workspace_folder defined above to store data for this project
    '-data', workspace_folder,
  },
  init_options = { bundles = bundles },
  on_attach = lsp_attach,
}

require('jdtls').start_or_attach(config)
