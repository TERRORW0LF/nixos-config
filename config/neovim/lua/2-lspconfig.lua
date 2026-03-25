local capabilities = require('cmp_nvim_lsp').default_capabilities()
local servers = { 'clangd', 'cmake', 'cssls', 'emmylua_ls', 'eslint', 'jsonls', 'nil_ls', 'ts_ls', 'rust_analyzer' }

for _, lsp in pairs(servers) do
	vim.lsp.config(lsp, {
		capabilities = capabilities,
	})
end

vim.lsp.config('nil_ls', {
	capabilities = capabilities,
	settings = {
		nix = {
			flake = {
				autoArchive = true,
			},
		},
	},
})
vim.lsp.config('emmylua_ls', {
	capabilities = capabilities,
	settings = {
		format = {
			externalTool = {
				program = 'stylua',
				args = { '-', '--stdin-filepath', '${file}', },
				timeout = 5000,
			},
			externalToolRangeFormat = {
				program = 'stylua',
				args = {
					'-',
					'--stdin-filepath',
					'${file}',
					'--indent-width=${indent_size}',
					'--indent-type',
					'${use_tabs?Tabs:Spaces}',
					'--range-start=${start_offset}',
					'--range-end=${end_offset}',
				},
				timeout = 5000,
			},
		},
	},
})

for _, lsp in pairs(servers) do
	vim.lsp.enable(lsp)
end

vim.api.nvim_create_autocmd('User', {
	pattern = 'DirenvLoaded',
	callback = function()
		for _, lsp in pairs(servers) do
			vim.lsp.enable(lsp)
		end
	end,
})
