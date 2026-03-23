require('better_escape').setup({
	timeout = 1000,
	default_mappings = false,
	mappings = {
		i = {
			j = {
				k = '<Esc>',
			},
		},
		c = {
			j = {
				k = '<C-c>',
			},
		},
	},
})
