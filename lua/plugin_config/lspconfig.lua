local plugin_name = 'lspconfig'
local ret_ok, inst = pcall(require, plugin_name)
if not ret_ok then
    vim.notify(plugin_name .. ' not found.')
    return
end

-- Common settings
local flags = {
    debounce_text_changes = 150,
}

local on_attach = function(client, bufnr)
    -- Disable code formatting
    --client.resolved_capabilities.document_formatting = false
    --client.resolved_capabilities.document_range_formatting = false

    local function buf_set_keymap(...)
        vim.api.nvim_buf_set_keymap(bufnr, ...)
    end
    require('keybinding').lsp(buf_set_keymap)

    -- Auto format when the file is saved.
    --vim.cmd('autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()')

    -- Code outline with Aerial
    require('aerial').on_attach(client, bufnr)
end

local settings = {}

-- Lua
local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, 'lua/?.lua')
table.insert(runtime_path, 'lua/?/init.lua')

settings.Lua = {
   runtime = {
       -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
       version = 'LuaJIT',
       -- Setup your lua path
       path = runtime_path,
   },
   diagnostics = {
       -- Get the language server to recognize the `vim` global
       globals = { 'vim', 'use' },
   },
   workspace = {
       -- Make the server aware of Neovim runtime files
       library = vim.api.nvim_get_runtime_file('', true),
       checkThirdParty = false,
   },
   -- Do not send telemetry data containing a randomized but unique identifier
   telemetry = {
       enable = false,
   },
}

inst.sumneko_lua.setup({
    on_attach = on_attach,
    flags = flags,
    settings = settings,
})

-- C/C++
inst.clangd.setup({
    on_attach = on_attach,
    flags = flags,
})

-- Python
inst.pylsp.setup({})

-- Latex
inst.texlab.setup({})
