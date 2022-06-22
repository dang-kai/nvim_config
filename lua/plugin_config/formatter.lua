local plugin_name = 'formatter'
local ret_ok, inst = pcall(require, plugin_name)
if not ret_ok then
    vim.notify(plugin_name .. ' not found.')
    return
end

inst.setup({
    filetype = {
        lua = {
            function()
                return {
                    exe = 'stylua',
                    args = {
                        '--config-path',
                        '~/.config/nvim/lua/plugin_config/style/lua.toml',
                        '--',
                        '-',
                    },
                    stdin = true,
                }
            end,
        },
    },
})
