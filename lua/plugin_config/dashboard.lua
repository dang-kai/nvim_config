local plugin_name = 'dashboard'
local ret_ok, inst = pcall(require, plugin_name)
if not ret_ok then
    vim.notify(plugin_name .. ' not found.')
    return
end

inst.custom_header = {
    [[]],
    [[ ███╗   ██╗ ███████╗ ██████╗  ██╗   ██╗ ██╗ ███╗   ███╗ ]],
    [[ ████╗  ██║ ██╔════╝██╔═══██╗ ██║   ██║ ██║ ████╗ ████║ ]],
    [[ ██╔██╗ ██║ █████╗  ██║   ██║ ██║   ██║ ██║ ██╔████╔██║ ]],
    [[ ██║╚██╗██║ ██╔══╝  ██║   ██║ ╚██╗ ██╔╝ ██║ ██║╚██╔╝██║ ]],
    [[ ██║ ╚████║ ███████╗╚██████╔╝  ╚████╔╝  ██║ ██║ ╚═╝ ██║ ]],
    [[ ╚═╝  ╚═══╝ ╚══════╝ ╚═════╝    ╚═══╝   ╚═╝ ╚═╝     ╚═╝ ]],
    [[]],
    [[]],
}

inst.custom_center = {
    {
        icon = '  ',
        desc = 'Projects                            ',
        action = 'Telescope projects',
    },
    {
        icon = '  ',
        desc = 'Recent files                        ',
        action = 'Telescope oldfiles',
    },
    {
        icon = '  ',
        desc = 'Edit Neovim config                  ',
        action = 'edit ~/.config/nvim/lua/config.lua',
    },
    {
        icon = '  ',
        desc = 'Edit Projects                       ',
        action = 'edit ~/.local/share/nvim/project_nvim/project_history',
    },
}

inst.custom_footer = {
    '',
    '',
    'Ver. 0.2.0 by DK',
}
