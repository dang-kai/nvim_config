--  Known issues: 
--      Program output printed in REPL window instead of Terminal.
--  TODOs:
--      Add python config.

local plugin_name = 'dap'
local ret_ok, dap = pcall(require, plugin_name)
if not ret_ok then
    vim.notify(plugin_name .. ' not found.')
    return
end

plugin_name = 'dapui'
local ui_ok, dapui = pcall(require, plugin_name)
if not ui_ok then
    vim.notify(plugin_name .. ' not found.')
    return
end

plugin_name = "nvim-dap-virtual-text"
local vt_ok, dapvt = pcall(require, plugin_name)
if not vt_ok then
    vim.notify(plugin_name .. ' not found.')
    return
end

-- Create debug commands
vim.api.nvim_create_user_command('DAPToggleBreakPoint', function()
    require('dap').toggle_breakpoint()
end, {})
vim.api.nvim_create_user_command('DAPSetConditionalBreakPoint', function()
    require('dap').set_breakpoint(vim.fn.input('[Condition] >'))
end, {})
vim.api.nvim_create_user_command('DAPEval', function()
    require('dapui').eval()
end, {})
vim.api.nvim_create_user_command('DAPContinue', function()
    require('dap').continue()
end, {})
vim.api.nvim_create_user_command('DAPTerminate', function()
    require('dap').terminate()
end, {})
vim.api.nvim_create_user_command('DAPRunToCursor', function()
    require('dap').run_to_cursor()
end, {})
vim.api.nvim_create_user_command('DAPStepOver', function()
    require('dap').step_over()
end, {})
vim.api.nvim_create_user_command('DAPStepInto', function()
    require('dap').step_into()
end, {})
vim.api.nvim_create_user_command('DAPStepOut', function()
    require('dap').step_out()
end, {})

-- Config dap icons
vim.fn.sign_define('DapBreakpoint', { text = '', texthl = '', linehl = '', numhl = '' })
vim.fn.sign_define('DapStopped', { text = ' ', texthl = '', linehl = '', numhl = '' })
vim.fn.sign_define('DapBreakpointCondition', { text = '', texthl = '', linehl = '', numhl = '' })
vim.fn.sign_define('DapLogPoint', { text = '', texthl = '', linehl = '', numhl = '' })
vim.fn.sign_define('DapBreakpointRejected', { text = '', texthl = '', linehl = '', numhl = '' })

-- Debug adapter config
dap.adapters.gdb = {
    type = 'executable',
    command = 'gdb',
    args = { '--interpreter=dap', '--eval-command', 'set print pretty on' }
}
-- Launch config
dap.configurations.c = {
    {
        name = 'Launch executable',
        type = 'gdb',
        request = 'launch',
        program = function()
            return vim.fn.input('Launch: ', vim.fn.getcwd() .. '/', 'file')
        end,
        cwd = '${workspaceFolder}',
        stopAtBeginningOfMainSubprogram = true,
        console = 'integratedTerminal', -- Output to Terminal window in dapui. Not working.
    },
}

-- Start dapui automatically
dap.listeners.before.attach.dapui_config = function()
    dapui.open()
end
dap.listeners.before.launch.dapui_config = function()
    dapui.open()
end
dap.listeners.after.terminate.dapui_config = function()
    dapui.close()
end
dap.listeners.after.disconnect.dapui_config = function()
    dapui.close()
end
dap.listeners.after.event_exited.dapui_config = function()
    dapui.close()
end

-- DAP UI -------------------------------------------------------------------------------
dapui.setup({
    icons = { expanded = '', collapsed = '' },
    mappings = {
        -- Use a table to apply multiple mappings
        expand = { 'o', '<2-LeftMouse>', '<CR>' },
        open = 'O',
        remove = 'd',
        edit = 'e',
        repl = 'r',
        toggle = 't',
    },
    layouts = {
        {
            elements = {
                { id = 'scopes', size = 0.5 },
                { id = 'watches', size = 0.2 },
                { id = 'stacks', size = 0.15 },
                { id = 'breakpoints', size = 0.15 },
            },
            size = 0.2,
            position = 'left',
        },
        {
            elements = {
                --{ id = "repl", size = 0.5 },
                { id = 'console', size = 0.2 },
                { id = 'repl', size = 0.8 },
            },
            size = 0.2,
            position = 'right',
        },
    },
    floating = {
        --max_height = nil, -- These can be integers or a float between 0 and 1.
        --max_width = nil, -- Floats will be treated as percentage of your screen.
        border = 'single', -- Border style. Can be "single", "double" or "rounded"
        mappings = {
            close = { 'q', '<Esc>' },
        },
    },
    render = { indent = 1, max_value_lines = 100 },
})

-- VIRTUALTEXT --------------------------------------------------------------------------
dapvt.setup {
    enabled = true,                        -- enable this plugin (the default)
    enabled_commands = true,               -- create commands DapVirtualTextEnable, DapVirtualTextDisable, DapVirtualTextToggle, (DapVirtualTextForceRefresh for refreshing when debug adapter did not notify its termination)
    highlight_changed_variables = true,    -- highlight changed values with NvimDapVirtualTextChanged, else always NvimDapVirtualText
    highlight_new_as_changed = false,      -- highlight new variables in the same way as changed variables (if highlight_changed_variables)
    show_stop_reason = true,               -- show stop reason when stopped for exceptions
    commented = false,                     -- prefix virtual text with comment string
    only_first_definition = true,          -- only show virtual text at first definition (if there are multiple)
    all_references = false,                -- show virtual text on all all references of the variable (not only definitions)
    filter_references_pattern = '<module', -- filter references (not definitions) pattern when all_references is activated (Lua gmatch pattern, default filters out Python modules)
    -- experimental features:
    virt_text_pos = 'eol',                 -- position of virtual text, see `:h nvim_buf_set_extmark()`
    all_frames = false,                    -- show virtual text for all stack frames not only current. Only works for debugpy on my machine.
    virt_lines = false,                    -- show virtual lines instead of virtual text (will flicker!)
    virt_text_win_col = nil                -- position the virtual text at a fixed window column (starting from the first text column) ,
                                           -- e.g. 80 to position at column 80, see `:h nvim_buf_set_extmark()`
}
