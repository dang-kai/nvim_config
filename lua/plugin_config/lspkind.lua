local plugin_name = 'lspkind'
local ret_ok, inst = pcall(require, plugin_name)
if not ret_ok then
    vim.notify(plugin_name .. ' not found.')
    return
end

-- Seems to have no effect and can be replaced by config method 2 (see github).
--inst.init({
--    -- defines how annotations are shown
--    -- default: symbol
--    -- options: 'text', 'text_symbol', 'symbol_text', 'symbol'
--    mode = 'symbol',
--
--    -- default symbol map
--    -- can be either 'default' (requires nerd-fonts font) or
--    -- 'codicons' for codicon preset (requires vscode-codicons font)
--    -- default: 'default'
--    preset = 'codicons',
--
--    -- override preset symbols
--    -- default: {}
--    symbol_map = {
--      Text = "",
--      Method = "",
--      Function = "",
--      Constructor = "",
--      Field = "ﰠ",
--      Variable = "",
--      Class = "ﴯ",
--      Interface = "",
--      Module = "",
--      Property = "ﰠ",
--      Unit = "塞",
--      Value = "",
--      Enum = "",
--      Keyword = "",
--      Snippet = "",
--      Color = "",
--      File = "",
--      Reference = "",
--      Folder = "",
--      EnumMember = "",
--      Constant = "",
--      Struct = "פּ",
--      Event = "",
--      Operator = "",
--      TypeParameter = ""
--    },
--})

local M ={}
M.formatting = {
    format = inst.cmp_format({
      --mode = 'symbol_text',
      mode = 'symbol', -- show only symbol annotations

      maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
      -- The function below will be called before any actual modifications from lspkind
      -- so that you can provide more controls on popup customization. (See [#30](https://github.com/onsails/lspkind-nvim/pull/30))
      before = function (entry, vim_item)
        -- Show hint source.
        --vim_item.menu = "[" .. string.upper(entry.source.name) .. "]"
        return vim_item
      end
    })
}

return M
