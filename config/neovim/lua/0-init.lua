vim.g.mapleader = " "
vim.diagnostic.enable = true
vim.diagnostic.config({
	virtual_lines = true,
})
vim.api.nvim_create_autocmd('LspAttach', {
	group = vim.api.nvim_create_augroup('lsp', { clear = true }),
	callback = function(args)
		vim.api.nvim_create_autocmd('BufWritePre', {
			buffer = args.buf,
			callback = function()
				vim.lsp.buf.format { async = false, id = args.data.client_id }
			end,
		})
	end
})

local nav_opts = { buffer = 0 }
vim.keymap.set({'n', 'i', 't'}, '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
vim.keymap.set({'n', 'i', 't'}, '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
vim.keymap.set({'n', 'i', 't'}, '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
vim.keymap.set({'n', 'i', 't'}, '<C-l>', [[<Cmd>wincmd l<CR>]], opts)

