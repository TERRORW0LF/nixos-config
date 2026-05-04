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

vim.keymap.set('n', '<leader>tcp', [[:Task set_module_param cmake]], { silent = true })
vim.keymap.set('n', '<leader>tcc', [[:Task start cmake configure<cr>]], { silent = true })
vim.keymap.set('n', '<leader>tcC', [[:Task start cmake reconfigure<cr>]], { silent = true })
vim.keymap.set('n', '<leader>tcb', [[:Task start cmake build<cr>]], { silent = true })
vim.keymap.set('n', '<leader>tcB', [[:Task start cmake build_all<cr>]], { silent = true })
vim.keymap.set('n', '<leader>tcr', [[:Task start cmake run<cr>]], { silent = true })
vim.keymap.set('n', '<leader>tcd', [[:Task start cmake debug<cr>]], { silent = true })
vim.keymap.set('n', '<leader>tct', [[:Task start cmake test<cr>]], { silent = true })
vim.keymap.set('n', '<leader>tck', [[:Task start cmake clean<cr>]], { silent = true })

vim.keymap.set('n', '<leader>trp', [[:Task set_module_param cargo]], { silent = true })
vim.keymap.set('n', '<leader>trb', [[:Task start cargo build<cr>]], { silent = true })
vim.keymap.set('n', '<leader>trr', [[:Task start cargo run<cr>]], { silent = true })
vim.keymap.set('n', '<leader>trd', [[:Task start cargo debug<cr>]], { silent = true })
vim.keymap.set('n', '<leader>trt', [[:Task start cargo test<cr>]], { silent = true })
vim.keymap.set('n', '<leader>trT', [[:Task start cargo debug_test<cr>]], { silent = true })
vim.keymap.set('n', '<leader>trk', [[:Task start cargo clean<cr>]], { silent = true })
''
