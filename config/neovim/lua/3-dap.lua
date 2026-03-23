local dap = require('dap')
dap.adapters.dart = {
  type = 'executable',
  command = 'dart',
  args = { 'debug_adapter' },
}
dap.adapters.flutter = {
  type = 'executable',
  command = 'flutter',
  args = { 'debug_adapter' },
}
dap.adapters.lldb = {
	type = 'executable',
	command = 'lldb-dap',
	name = 'lldb'
}
dap.adapters['pwa-node'] = {
	type = 'server',
	host = 'localhost',
	port = '${port}',
	executable = {
		command = 'js-debug',
		args = {
			'${port}'
		}
	}
}

dap.configurations.cpp = {
	{
		name = 'Launch',
		type = 'lldb',
		request = 'launch',
		program = function()
			return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
		end,
		cwd = '${workspaceFolder}',
		stopOnEntry = false,
		args = {},
	},
}
dap.configurations.c = dap.configurations.cpp
dap.configurations.dart = {
  {
    type = "dart",
    request = "launch",
    name = "Launch dart",
    dartSdkPath = nil, 
    flutterSdkPath = nil, 
    program = nil, 
    cwd = "${workspaceFolder}",
  },
  {
    type = "flutter",
    request = "launch",
    name = "Launch flutter",
    dartSdkPath = nil, 
    flutterSdkPath = nil, 
    program = nil, 
    cwd = "${workspaceFolder}",
  }
}
dap.configurations.typesript = {
	{
		type = 'pwa-node',
		request = 'launch',
		name = 'Launch file',
		program = '${file}',
		cwd = '${workspaceFolder}'
	}
}
dap.configurations.javascript = dap.configurations.typescript
dap.configurations.rust = {
	{
		name = 'Launch',
		type = 'lldb',
		request = 'launch',
		program = function()
			return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
		end,
		cwd = '${workspaceFolder}',
		stopOnEntry = false,
		args = {},
		initCommands = function()
		-- Find out where to look for the pretty printer Python module.
		local rustc_sysroot = vim.fn.trim(vim.fn.system 'rustc --print sysroot')
		assert(
			vim.v.shell_error == 0,
			'failed to get rust sysroot using `rustc --print sysroot`: ' .. rustc_sysroot
		)
		local script_file = rustc_sysroot .. '/lib/rustlib/etc/lldb_lookup.py'
		local commands_file = rustc_sysroot .. '/lib/rustlib/etc/lldb_commands'

		-- The following is a table/list of lldb commands, which have a syntax
		-- similar to shell commands.
		--
		-- To see which command options are supported, you can run these commands
		-- in a shell:
		--
		--   * lldb --batch -o 'help command script import'
		--   * lldb --batch -o 'help command source'
		--
		-- Commands prefixed with `?` are quiet on success (nothing is written to
		-- debugger console if the command succeeds).
		--
		-- Prefixing a command with `!` enables error checking (if a command
		-- prefixed with `!` fails, subsequent commands will not be run).
		--
		-- NOTE: it is possible to put these commands inside the ~/.lldbinit
		-- config file instead, which would enable rust types globally for ALL
		-- lldb sessions (i.e. including those run outside of nvim). However,
		-- that may lead to conflicts when debugging other languages, as the type
		-- formatters are merely regex-matched against type names. Also note that
		-- .lldbinit doesn't support the `!` and `?` prefix shorthands.
		return {
			([[!command script import '%s']]):format(script_file),
			([[command source '%s']]):format(commands_file),
		}
		end,
	},
}

local dapui = require('dap.ui.widgets')
local daprepl = require('dap.repl')
vim.keymap.set('n', '<leader>dh', dapui.hover)
vim.keymap.set('n', '<leader>ds', function() 
	dapui.centered_float(dapui.scopes) 
end) 
vim.keymap.set('n', '<leader>dc', dap.continue)
vim.keymap.set('n', '<leader>dn', dap.step_over)
vim.keymap.set('n', '<leader>di', dap.step_into)
vim.keymap.set('n', '<leader>do', dap.step_over)
vim.keymap.set('n', '<leader>db', dap.toggle_breakpoint)
vim.keymap.set('n', '<leader>dB', function()
	dap.toggle_breakpoint(vim.fn.input('Breakpoint condition: '))
end)
vim.keymap.set('n', '<leader>dl', dap.list_breakpoints)
vim.keymap.set('n', '<leader>dc', dap.clear_breakpoints)
vim.keymap.set('n', '<leader>de', dap.set_exception_breakpoints)
vim.keymap.set('n', '<leader>dr', daprepl.toggle)
