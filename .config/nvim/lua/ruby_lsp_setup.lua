-- Ruby LSP setup helper
-- This ensures proper gem indexing and navigation

local M = {}

-- Function to ensure ruby-lsp can find gems
function M.setup_ruby_project()
  -- Ensure we're in a Ruby project
  local gemfile = vim.fn.findfile("Gemfile", ".;")
  if gemfile == "" then
    return
  end

  -- Set up environment for ruby-lsp to find gems
  vim.env.BUNDLE_GEMFILE = vim.fn.fnamemodify(gemfile, ":p")
  
  -- Restart ruby-lsp when switching projects
  vim.api.nvim_create_autocmd("DirChanged", {
    callback = function()
      local new_gemfile = vim.fn.findfile("Gemfile", ".;")
      if new_gemfile ~= "" then
        vim.env.BUNDLE_GEMFILE = vim.fn.fnamemodify(new_gemfile, ":p")
        -- Restart LSP clients
        vim.cmd("LspRestart ruby_lsp")
      end
    end,
  })
end

-- Enhance LSP on_attach for Ruby files
function M.on_attach(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Ruby-specific mappings
  local opts = { noremap=true, silent=true, buffer=bufnr }
  
  -- Don't override gd, let the global mapping handle it
  
  -- Alternative definition search if first doesn't work
  vim.keymap.set('n', '<leader>gd', function()
    vim.lsp.buf.type_definition()
  end, opts)
  
  -- Enhanced workspace symbol search for gems
  vim.keymap.set('n', '<leader>sy', function()
    vim.lsp.buf.workspace_symbol(vim.fn.expand('<cword>'))
  end, opts)
end

-- Function to check ruby-lsp status
function M.check_status()
  local clients = vim.lsp.get_clients()
  for _, client in pairs(clients) do
    if client.name == "ruby_lsp" then
      print("Ruby LSP is running")
      print("Root dir: " .. (client.config.root_dir or "unknown"))
      print("Status: " .. (client.is_stopped() and "stopped" or "running"))
      return
    end
  end
  print("Ruby LSP is not running")
end

return M