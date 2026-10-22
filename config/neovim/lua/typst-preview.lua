require('typst-preview').setup({
	dependencies_bin = {
		tinymist = 'tinymist',
		websocat = 'websocat',
	},
})

vim.keymap.set('n', '<leader>lp', [[<Cmd>TypstPreviewToggle<CR>]])
