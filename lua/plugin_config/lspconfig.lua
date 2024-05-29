local plugin_name = 'lspconfig'
local ret_ok, inst = pcall(require, plugin_name)
if not ret_ok then
    vim.notify(plugin_name .. ' not found.')
    return
end

-- General vim diagnostic config.
vim.diagnostic.config({
    virtual_text = true,
    virtual_lines = false, -- Set to true to use lsp_lines
    signs = false,
    update_in_insert = false,
})
local signs = { Error = ' ', Warn = ' ', Hint = ' ', Info = ' ' }
for type, icon in pairs(signs) do
    local hl = 'DiagnosticSign' .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

-- Common settings
local flags = {
    debounce_text_changes = 200,
}

local on_attach = function(client, bufnr)
    local map = vim.api.nvim_buf_set_keymap
    local m = { noremap = true, silent = true }

    -- rename
    --map(bufnr, "n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", m)
    -- code action
    --map(bufnr, "n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", m)
    -- go xx
    map(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', m)
    map(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', m)
    map(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', m)
    map(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', m)
    --map(bufnr, "n", "gr", "<cmd>Lspsaga rename<CR>", m)

    map(bufnr, 'n', 'gh', '<cmd>lua vim.lsp.buf.hover()<CR>', m)
    --map(bufnr, "n", "gh", "<cmd>Lspsaga preview_definition<CR>", m)
    --map(bufnr, "n", "gh", "<cmd>Lspsaga hover_doc<CR>", m)
    --map(bufnr, "n", "gf", "<cmd>Lspsaga lsp_finder<CR>", m)

    map(bufnr, 'n', 'gf', '<cmd>lua vim.diagnostic.open_float()<CR>', m)
    map(bufnr, 'n', 'gk', '<cmd>lua vim.diagnostic.goto_prev()<CR>', m)
    map(bufnr, 'n', 'gj', '<cmd>lua vim.diagnostic.goto_next()<CR>', m)
    --map(bufnr, "n", "th", ":ClangdSwitchSourceHeader<CR>", m) -- Toggle header.
    map(bufnr, 'n', 'th', ':e %:p:s,.h$,.X123X,:s,.c$,.h,:s,.X123X$,.c,<CR>', m) -- Toggle header without clang (only in current folder).

    -- map(bufnr, "n", "<leader>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", m)
    -- map(bufnr, "n", "<leader>q", "<cmd>lua vim.diagnostic.setloclist()<CR>", m)
    -- map(bufnr, "n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", m)
    -- map(bufnr, "n", "<space>wa", "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", m)
    -- map(bufnr, "n", "<space>wr", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", m)
    -- map(bufnr, "n", "<space>wl", "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>", m)
    -- map(bufnr, "n", "<space>D", "<cmd>lua vim.lsp.buf.type_definition()<CR>", m)

    -- Auto format when the file is saved.
    --vim.cmd('autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()')
end

-- Lua
local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, 'lua/?.lua')
table.insert(runtime_path, 'lua/?/init.lua')

inst.lua_ls.setup({
    on_attach = on_attach,
    flags = flags,
    settings = {
        Lua = {
            runtime = {
                -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                version = 'LuaJIT',
                -- Setup your lua path
                --path = runtime_path,
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
        },
    },
})

-- C/C++
inst.clangd.setup({
    on_attach = on_attach,
    flags = flags,
})

-- Python REMEMBER TO INSTALL STUBS IN CASE OF TYPE CHECK ERROR
inst.pyright.setup({
    on_attach = on_attach,
    flags = flags,
    settings = { pyright = {}, python = { analysis = { typeCheckingMode = 'stardard' } } },
    -- Configuration reference: https://www.reddit.com/r/neovim/comments/y3mkpp/nvim_masonlspconfig_pyright_configuration/
})
--inst.pylsp.setup({
--    on_attach = on_attach,
--    flags = flags,
--    settings = { pylsp = { plugins = {
--        pyflakes = { enabled = true },
--        -- Configuration reference: https://github.com/python-lsp/python-lsp-server/blob/develop/CONFIGURATION.md
--        pycodestyle = { ignore = { 'E501', 'E741', 'E266' } },
--    } } },
--})

-- Latex
inst.texlab.setup({
    on_attach = on_attach,
    flags = flags,
})
