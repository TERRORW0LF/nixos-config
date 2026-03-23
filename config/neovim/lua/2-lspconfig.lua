local capabilities = require('cmp_nvim_lsp').default_capabilities()
local servers = { 'clangd', 'cmake', 'cssls', 'eslint', 'jsonls', 'ts_ls', 'rust_analyzer' }
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
vim.lsp.enable('nil_ls')
for _, lsp in pairs(servers) do
  vim.lsp.config(lsp, {
    capabilities = capabilities,
  })
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
