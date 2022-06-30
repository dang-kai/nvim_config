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
    vim.notify("Debug initialized.")
    debug_open()
end
inst.listeners.before.event_terminated["dapui_config"] = function()
    vim.notify("Debug terminated.")
    debug_close()
end
inst.listeners.before.event_exited["dapui_config"] = function()
    vim.notify("Debug exited.")
    debug_close()
end
inst.listeners.before.disconnect["dapui_config"] = function()
    vim.notify("Debug disconnected.")
    debug_close()
end

-- Debugger
-- TODO: wait dap-ui for fixing temrinal layout
-- the "30" of "30vsplit: doesn't work
inst.defaults.fallback.terminal_win_cmd = "30vsplit new" -- this will be overrided by dapui
inst.set_log_level("DEBUG")

-- C/C++ adapter config
inst.adapters.lldb = {
    type = "executable",
    command = "/usr/bin/lldb-vscode",
}

-- Python adapter config
inst.adapters.debugpy = {
    type = "executable",
    command = "/usr/bin/python",
    args = { "-m", "debugpy.adapter" },
}

-- Project specific launch config is loaded from launch.json. Global settings (see bottom of the file) are no longer used
require("dap.ext.vscode").load_launchjs("launch.json", { debugpy = { "python" }, lldb = { "c", "cpp" } })

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
--
--inst.configurations.c = {
--    {
--        name = "C Debug",
--        type = "c_lldb",
--        request = "launch",
--        cwd = "${workspaceFolder}",
--        stopOnEntry = true,
--        runInTerminal = false, -- Set to true requires extra configuration, see bottom of the file.
--    },
--}
--
--inst.configurations.cpp = {
--    {
--        name = "C++ Debug",
--        type = "c_lldb",
--        request = "launch",
--        cwd = "${workspaceFolder}",
--        stopOnEntry = true,
--        runInTerminal = false, -- Set to true requires extra configuration, see bottom of the file.
--    },
--}
--inst.configurations.python = {
--    {
--        name = "Python debug",
--        type = "python_debugpy",
--        request = "launch",
--        cwd = "${workspaceFolder}",
--        stopOnEntry = true,
--        runInTerminal = false, -- Set to true requires extra configuration, see bottom of the file.
--        --program = "${file}"
--    },
--}
