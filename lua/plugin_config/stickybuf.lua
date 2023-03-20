local plugin_name = 'stickybuf'
local ret_ok, inst = pcall(require, plugin_name)
if not ret_ok then
    vim.notify(plugin_name .. ' not found.')
    return
end

inst.setup({
  -- This function is run on BufEnter to determine pinning should be activated
  get_auto_pin = function(bufnr)
    -- You can return "bufnr", "buftype", "filetype", or a custom function to set how the window will be pinned
    -- The function below encompasses the default logic. Inspect the source to see what it does.
    return require("stickybuf").should_auto_pin(bufnr)
  end
})
