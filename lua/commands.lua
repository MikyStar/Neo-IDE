local command = vim.api.nvim_create_user_command

command("CloseBuffers", function()
  vim.cmd("%bd")
end, {})

command("CloseQuickfixes", function()
  vim.cmd("cexpr []")
end, {})

command("CloseOtherBuffers", function()
  local current_buf = vim.api.nvim_get_current_buf()
  local buffers = vim.api.nvim_list_bufs()

  for _, buf in ipairs(buffers) do
    -- Skip current buffer and invalid buffers
    if buf ~= current_buf and vim.api.nvim_buf_is_valid(buf) then
      local buftype = vim.bo[buf].buftype
      local filetype = vim.bo[buf].filetype

      -- Don't close special buffers like NvimTree, terminals, etc.
      if buftype == "" and filetype ~= "NvimTree" then
        pcall(vim.api.nvim_buf_delete, buf, { force = false })
      end
    end
  end
end, {})

command("TODO", function()
  vim.cmd(":TodoTelescope") -- From folke/todo-comments
end, {})
