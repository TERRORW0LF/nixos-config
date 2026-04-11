require('direnv').setup({
    autoload_direnv = true,
    statusline = {
        enabled = true,
    },
	keybindings = {
		allow = "<Leader>ea",
		deny = "<Leader>ed",
		reload = "<Leader>er",
		edit = "<Leader>ee",
	},
})

