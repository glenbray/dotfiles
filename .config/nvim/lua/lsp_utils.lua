-- Universal LSP utilities for all languages

local M = {}

-- Go to definition in new tab (works for all LSP-enabled languages)
function M.go_to_definition_in_tab()
  -- First, let's try the standard definition to see if anything is found
  local params = vim.lsp.util.make_position_params()
  local current_file = vim.api.nvim_buf_get_name(0)
  
  -- Use the standard LSP handler but intercept the result
  local original_handler = vim.lsp.handlers['textDocument/definition']
  
  -- Temporarily override the handler
  vim.lsp.handlers['textDocument/definition'] = function(err, result, ctx, config)
    -- Restore the original handler immediately
    vim.lsp.handlers['textDocument/definition'] = original_handler
    
    if err or not result or vim.tbl_isempty(result) then
      vim.notify('No definition found')
      return
    end
    
    -- Get the location
    local location = result[1] or result
    local uri = location.uri or location.targetUri
    local range = location.range or location.targetSelectionRange or location.range
    
    -- Convert URI to file path
    local filepath = vim.uri_to_fname(uri)
    
    -- Check if definition is in the same file
    if filepath == current_file then
      -- Same file - use the original handler behavior (same window)
      original_handler(err, result, ctx, config)
    else
      -- Different file - open in new tab
      vim.cmd('tabnew')
      vim.cmd('edit ' .. vim.fn.fnameescape(filepath))
      
      -- Jump to the specific position
      if range and range.start then
        local line = range.start.line + 1
        local col = range.start.character
        vim.api.nvim_win_set_cursor(0, {line, col})
      end
    end
  end
  
  -- Now call the standard definition function
  vim.lsp.buf.definition()
end

return M