require('auto-session').setup({
	auto_restore_last_session = true,
	cwd_change_handling = true,
	suppressed_dirs = { '~/', '~/Downloads', '~/GitRepos' },
})
vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"
