local plugin_name = "cmp"
local ret_ok, inst = pcall(require, plugin_name)
if not ret_ok then
    vim.notify(plugin_name .. " not found.")
    return
end

local keymap = function(inst_cmp)
    return {
        ["<A-.>"] = inst_cmp.mapping(inst_cmp.mapping.complete(), { "i", "c" }),
        ["<A-,>"] = inst_cmp.mapping({
            i = inst_cmp.mapping.abort(),
            c = inst_cmp.mapping.close(),
        }),
        ["<C-K>"] = inst_cmp.mapping.select_prev_item(),
        ["<C-J>"] = inst_cmp.mapping.select_next_item(),
        ["<TAB>"] = inst_cmp.mapping.confirm({
            select = true,
            behavior = inst_cmp.ConfirmBehavior.Replace,
        }),
        --["<CR>"] = inst_cmp.mapping.confirm({
        --    select = true,
        --    behavior = inst_cmp.ConfirmBehavior.Replace,
        --}),
        ["<C-U>"] = inst_cmp.mapping(inst_cmp.mapping.scroll_docs(-3), { "i", "c" }),
        ["<C-D>"] = inst_cmp.mapping(inst_cmp.mapping.scroll_docs(3), { "i", "c" }),
    }
end

inst.setup({
    snippet = {
        expand = function(args)
            -- For `vsnip` users.
            vim.fn["vsnip#anonymous"](args.body)

            -- For `luasnip` users.
            -- require('luasnip').lsp_expand(args.body)

            -- For `ultisnips` users.
            -- vim.fn["UltiSnips#Anon"](args.body)

            -- For `snippy` users.
            -- require'snippy'.expand_snippet(args.body)
        end,
    },
    sources = inst.config.sources({
        { name = "nvim_lsp" },
        -- For vsnip users.
        { name = "vsnip" },

        -- For luasnip users.
        -- { name = 'luasnip' },

        --For ultisnips users.
        -- { name = 'ultisnips' },

        -- -- For snippy users.
        -- { name = 'snippy' },
    }, { { name = "buffer" }, { name = "path" } }),

    mapping = keymap(inst),

    formatting = require("plugin_config.lspkind").formatting,
})

---- Use buffer source in search('\') mode.
--inst.setup.cmdline('/', {
--    mapping = inst.mapping.preset.cmdline(),
--    sources = {
--        { name = 'buffer' },
--    },
--})
--
---- Use path and cmdline sources in command mode.
--inst.setup.cmdline(':', {
--    mapping = inst.mapping.preset.cmdline(),
--    sources = inst.config.sources({
--        { name = 'path' },
--    }, {
--        { name = 'cmdline' },
--    }),
--})
