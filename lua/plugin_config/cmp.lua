local plugin_name = 'cmp'
local ret_ok, inst = pcall(require, plugin_name)
if not ret_ok then
    vim.notify(plugin_name .. ' not found.')
    return
end

inst.setup({
    snippet = {
        expand = function(args)
            -- For `vsnip` users.
            vim.fn['vsnip#anonymous'](args.body)

            -- For `luasnip` users.
            -- require('luasnip').lsp_expand(args.body)

            -- For `ultisnips` users.
            -- vim.fn["UltiSnips#Anon"](args.body)

            -- For `snippy` users.
            -- require'snippy'.expand_snippet(args.body)
        end,
    },
    sources = inst.config.sources({
        { name = 'nvim_lsp' },
        -- For vsnip users.
        { name = 'vsnip' },

        -- For luasnip users.
        -- { name = 'luasnip' },

        --For ultisnips users.
        -- { name = 'ultisnips' },

        -- -- For snippy users.
        -- { name = 'snippy' },
    }, { { name = 'buffer' }, { name = 'path' } }),

    mapping = require('keybinding').cmp(inst),

    formatting = require('plugin_config.lspkind').formatting,
})

-- Use buffer source in search('\') mode.
inst.setup.cmdline('/', {
    mapping = inst.mapping.preset.cmdline(),
    sources = {
        { name = 'buffer' },
    },
})

-- Use path and cmdline sources in command mode.
inst.setup.cmdline(':', {
    mapping = inst.mapping.preset.cmdline(),
    sources = inst.config.sources({
        { name = 'path' },
    }, {
        { name = 'cmdline' },
    }),
})
