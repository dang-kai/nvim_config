local plugin_name = 'formatter'
local ret_ok, inst = pcall(require, plugin_name)
if not ret_ok then
    vim.notify(plugin_name .. ' not found.')
    return
end

local util = require('formatter.util')

local filetype = {
    lua = {
        function()
            return {
                exe = 'stylua',
                args = {
                    '--call-parentheses',
                    'Always',
                    '--column-width',
                    '160',
                    '--indent-type',
                    'Spaces',
                    '--indent-width',
                    '4',
                    '--quote-style',
                    'AutoPreferSingle',
                    '--line-endings',
                    'Unix',
                    '--',
                    '-',
                },
                stdin = true,
            }
        end,
    },
    c = {
        function()
            return {
                exe = 'clang-format',
                args = {
                      "--style='{BasedOnStyle: LLVM, IndentWidth: 4, SpaceBeforeParens: ControlStatements, ColumnLimit: 160, AlignTrailingComments: true, AlignConsecutiveAssignments: true, AlignConsecutiveMacros: true, AlignConsecutiveDeclarations: true, AlignAfterOpenBracket: true, AlignArrayOfStructures: Right, AlignEscapedNewlines: Left, AlignOperands: Align, IndentCaseLabels: true, AllowShortBlocksOnASingleLine: Always, AllowShortFunctionsOnASingleLine: All, AllowShortCaseLabelsOnASingleLine: true, AllowShortEnumsOnASingleLine: true, AllowShortIfStatementsOnASingleLine: AllIfsAndElse, AllowShortLoopsOnASingleLine: true}'",
                    '--assume-filename=' .. util.escape_path(util.get_current_buffer_file_name()),
                },
                stdin = true,
                try_node_modules = true,
            }
        end,
    },
    python = {
        function()
            return {
                exe = 'autopep8',
                args = {
                    '--aggressive',
                    '--max-line-length 160',
                    '-',
                },
                stdin = 1,
            }
        end,
    },
}

filetype.cpp = filetype.c
filetype.h = filetype.c
filetype.hpp = filetype.c

inst.setup({
    filetype = filetype,
})
