local capabilities = require('cmp_nvim_lsp').default_capabilities()
local servers = { 'clangd', 'cmake', 'cssls', 'eslint', 'jsonls', 'nil_ls', 'ts_ls', 'rust_analyzer' }
for _, lsp in pairs(servers) do
  vim.lsp.config(lsp, {
    capabilites = capabilities,
  })
  vim.lsp.enable(lsp)
end
