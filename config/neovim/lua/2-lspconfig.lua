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

vim.keymap.set('n', '<leader>ld', vim.lsp.buf.definition)
vim.keymap.set('n', '<leader>lt', vim.lsp.buf.type_definition)
vim.keymap.set('n', '<leader>la', vim.lsp.buf.code_action)
vim.keymap.set('n', '<leader>lH', vim.lsp.buf.hover)
vim.keymap.set('n', '<leader>lh', vim.lsp.buf.signature_help)
vim.keymap.set('n', '<leader>ls', vim.lsp.buf.document_symbol)
vim.keymap.set('n', '<leader>li', vim.lsp.buf.implementation)
vim.keymap.set('n', '<leader>lc', vim.lsp.buf.incoming_calls)
vim.keymap.set('n', '<leader>lr', vim.lsp.buf.references)
vim.keymap.set('n', '<leader>lR', vim.lsp.buf.rename)
vim.keymap.set('n', '<leader>lf', vim.lsp.buf.format)
