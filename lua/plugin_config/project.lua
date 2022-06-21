local plugin_name = 'project_nvim'
local ret_ok, inst = pcall(require, plugin_name) 
if not ret_ok then
    vim.notify(plugin_name .. ' not found.')
    return
end

vim.g.nvim_tree_respect_buf_cwd = 1 -- Support nvim-tree

inst.setup({
  detection_methods = { "pattern" },
  patterns = { ".git", "Makefile", "CMakeLists.txt" },
  --patterns = { ".git", "_darcs", ".hg", ".bzr", ".svn", "Makefile", "package.json", ".sln" },
})

local ret_ok, telescope = pcall(require, "telescope")
if not ret_ok then
  return
end
pcall(telescope.load_extension, "projects")
