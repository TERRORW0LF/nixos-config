# vim: ft=lua
{ pkgs }:
''
local Path = require('plenary.path')
require('tasks').setup({
	default_params = {
		cmake = {
			dap = {
				config = 'cpp',
				name = 'tasks',
			},
			cmake_kits_file = '${pkgs.static-configs}/neovim/kits.json', 
			cmake_build_types_file = '${pkgs.static-configs}/neovim/builds.json',
			build_kit = 'clang',
			build_type = 'dev-release',
		},
		cargo = {
			dap = {
				config = 'rust',
				name = 'tasks',
			},
		},
	},
})

vim.keymap.set('n', '<leader>tsc', [[:Task set_module_param cmake]], { silent = true })
vim.keymap.set('n', '<leader>tc', [[:Task start cmake configure<cr>]], { silent = true })
vim.keymap.set('n', '<leader>tC', [[:Task start cmake reconfigure<cr>]], { silent = true })
vim.keymap.set('n', '<leader>tb', [[:Task start cmake build<cr>]], { silent = true })
vim.keymap.set('n', '<leader>tB', [[:Task start cmake build_all<cr>]], { silent = true })
vim.keymap.set('n', '<leader>tr', [[:Task start cmake run<cr>]], { silent = true })
vim.keymap.set('n', '<leader>td', [[:Task start cmake debug<cr>]], { silent = true })
vim.keymap.set('n', '<leader>tt', [[:Task start cmake test<cr>]], { silent = true })
vim.keymap.set('n', '<leader>tk', [[:Task start cmake clean<cr>]], { silent = true })
''
