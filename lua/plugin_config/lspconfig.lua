local plugin_name = 'lspconfig'
local ret_ok, inst = pcall(require, plugin_name)
if not ret_ok then
    vim.notify(plugin_name .. ' not found.')
    return
end

-- Lua
local opt = require("plugin_config.lsp.lua")
inst.sumneko_lua.setup{
    on_attach = opt.on_attach,
    flags     = opt.flags,
    settings  = opt.settings,
}

-- C/C++
inst.clangd.setup{}

-- Python
inst.pylsp.setup{}

-- Latex
inst.texlab.setup{}

