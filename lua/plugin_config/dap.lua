local plugin_name = "dap"
local ret_ok, inst = pcall(require, plugin_name)
if not ret_ok then
    vim.notify(plugin_name .. " not found.")
    return
end

-- Config dap icons
vim.fn.sign_define("DapBreakpoint", { text = "", texthl = "", linehl = "", numhl = "" })
vim.fn.sign_define("DapStopped", { text = "", texthl = "", linehl = "", numhl = "" })
vim.fn.sign_define("DapBreakpointCondition", { text = "", texthl = "", linehl = "", numhl = "" })
vim.fn.sign_define("DapLogPoint", { text = "", texthl = "", linehl = "", numhl = "" })
vim.fn.sign_define("DapBreakpointRejected", { text = "", texthl = "", linehl = "", numhl = "" })

-- DAP ui
local ui = require("dapui")

local debug_open = function()
    ui.open()
    vim.api.nvim_command("DapVirtualTextEnable")
end
local debug_close = function()
    inst.repl.close()
    ui.close()
    vim.api.nvim_command("DapVirtualTextDisable")
    -- vim.api.nvim_command("bdelete! term:")   -- close debug temrinal
end

inst.listeners.after.event_initialized["dapui_config"] = function()
    debug_open()
end
inst.listeners.before.event_terminated["dapui_config"] = function()
    debug_close()
end
inst.listeners.before.event_exited["dapui_config"] = function()
    debug_close()
end
inst.listeners.before.disconnect["dapui_config"] = function()
    debug_close()
end

-- Debugger
-- TODO: wait dap-ui for fixing temrinal layout
-- the "30" of "30vsplit: doesn't work
inst.defaults.fallback.terminal_win_cmd = "30vsplit new" -- this will be overrided by dapui
inst.set_log_level("DEBUG")

-- C/C++ config
inst.adapters.lldb = {
    type = "executable",
    command = "/usr/bin/lldb-vscode",
    name = "lldb",
}

inst.configurations.c = {
    {
        name = "Launch",
        type = "lldb",
        request = "launch",
        program = function()
            return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
        end,
        cwd = "${workspaceFolder}",
        stopOnEntry = true,
        args = {},

        runInTerminal = false,
        -- if you change `runInTerminal` to true, you might need to change the yama/ptrace_scope setting:
        --
        --    echo 0 | sudo tee /proc/sys/kernel/yama/ptrace_scope
        --
        -- Otherwise you might get the following error:
        --
        --    Error on launch: Failed to attach to the target process
        --
        -- But you should be aware of the implications:
        -- https://www.kernel.org/doc/html/latest/admin-guide/LSM/Yama.html

        env = function()
            local variables = {}
            for k, v in pairs(vim.fn.environ()) do
                table.insert(variables, string.format("%s=%s", k, v))
            end
            return variables
        end,
    },
}

inst.configurations.cpp = inst.configurations.c
inst.configurations.rust = inst.configurations.c

-- Python config
inst.adapters.python = {
    type = "executable",
    command = "python",
    args = { "-m", "debugpy.adapter" },
}

inst.configurations.python = {
    -- launch exe
    {
        type = "python", -- the type here established the link to the adapter definition: `dap.adapters.python`
        request = "launch",
        name = "Launch",
        program = "${file}", -- This configuration will launch the current file if used.
        args = function()
            local input = vim.fn.input("Input args: ")
            return require("user.dap.dap-util").str2argtable(input)
        end,
        pythonPath = function()
            local venv_path = os.getenv("VIRTUAL_ENV")
            if venv_path then
                return venv_path .. "/bin/python"
            end
            return "/usr/bin/python"
        end,
    },
}
