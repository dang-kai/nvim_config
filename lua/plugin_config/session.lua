local plugin_name = 'session_manager'
local ret_ok, inst = pcall(require, plugin_name)
if not ret_ok then
    vim.notify(plugin_name .. ' not found.')
    return
end

local path = require('plenary.path')

inst.setup({
    sessions_dir = path:new(vim.fn.stdpath('data'), 'sessions'), -- The directory where the session files will be saved.
    path_replacer = '__', -- The character to which the path separator will be replaced for session files.
    colon_replacer = '++', -- The character to which the colon symbol will be replaced for session files.
    autoload_mode = require('session_manager.config').AutoloadMode.CurrentDir, -- Define what to do when Neovim is started without arguments. Possible values: Disabled, CurrentDir, LastSession
    autosave_last_session = true, -- Automatically save last session on exit and on session switch.
    autosave_ignore_not_normal = true, -- Plugin will not save a session when no buffers are opened, or all of them aren't writable or listed.
    autosave_ignore_filetypes = { -- All buffers of these file types will be closed before the session is saved.
        'gitcommit',
    },
    autosave_only_in_session = true, -- Always autosaves session. If true, only autosaves after a session is active.
    max_path_length = 160, -- Shorten the display path if length exceeds this threshold. Use 0 if don't want to shorten the path at all.
})

-- Open nvim-tree after loading session.
--vim.cmd([[
--    augroup _open_nvim_tree
--        autocmd! * <buffer>
--        autocmd SessionLoadPost * silent! lua require("nvim-tree").toggle(false, true)
--    augroup end
--]])
