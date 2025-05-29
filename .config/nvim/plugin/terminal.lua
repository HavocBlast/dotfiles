-- Variable to track the floating terminal state
local floating_terminal = {
  buf = nil,
  win = nil
}

-- Function to toggle floating terminal
local function toggle_floating_terminal()
  -- Check if terminal window exists and is valid
  if floating_terminal.win and vim.api.nvim_win_is_valid(floating_terminal.win) then
    -- Close the terminal
    vim.api.nvim_win_close(floating_terminal.win, true)
    floating_terminal.win = nil
    return
  end
  
  -- Get editor dimensions
  local width = vim.api.nvim_get_option("columns")
  local height = vim.api.nvim_get_option("lines")
  
  -- Calculate floating window dimensions (80% of screen)
  local win_height = math.ceil(height * 0.8)
  local win_width = math.ceil(width * 0.8)
  
  -- Calculate starting position to center the window
  local row = math.ceil((height - win_height) / 2 - 1)
  local col = math.ceil((width - win_width) / 2)
  
  -- Create or reuse buffer
  if not floating_terminal.buf or not vim.api.nvim_buf_is_valid(floating_terminal.buf) then
    floating_terminal.buf = vim.api.nvim_create_buf(false, true)
  end
  
  -- Window configuration
  local opts = {
    style = "minimal",
    relative = "editor",
    width = win_width,
    height = win_height,
    row = row,
    col = col,
    border = "rounded"
  }
  
  -- Create the floating window
  floating_terminal.win = vim.api.nvim_open_win(floating_terminal.buf, true, opts)
  
  -- Start terminal if buffer is empty (new buffer)
  if vim.api.nvim_buf_line_count(floating_terminal.buf) == 1 and 
     vim.api.nvim_buf_get_lines(floating_terminal.buf, 0, 1, false)[1] == "" then
    vim.fn.termopen(vim.o.shell)
  end
  
  -- Enter insert mode automatically
  vim.cmd("startinsert")
  
  -- Set buffer options
  vim.api.nvim_buf_set_option(floating_terminal.buf, "bufhidden", "hide")
  
  -- Optional: Set window-local options
  vim.api.nvim_win_set_option(floating_terminal.win, "winblend", 10) -- Slight transparency
  
  -- Set up autocommand to clean up when buffer is deleted
  vim.api.nvim_create_autocmd("BufWipeout", {
    buffer = floating_terminal.buf,
    callback = function()
      floating_terminal.buf = nil
      floating_terminal.win = nil
    end
  })
end

-- Create the keymap for toggling
vim.keymap.set("n", "<leader>tm", toggle_floating_terminal, { 
  desc = "Toggle floating terminal",
  noremap = true,
  silent = true 
})

-- Optional: Also allow toggling from terminal mode
vim.keymap.set("t", "<leader>tm", toggle_floating_terminal, { 
  desc = "Toggle floating terminal",
  noremap = true,
  silent = true 
})
