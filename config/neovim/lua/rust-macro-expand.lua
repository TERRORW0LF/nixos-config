vim.keymap.set('n', '<leader>le', function() require('rust-expand-macro').expand_macro('horizontal') end, { desc = 'Telescope find files' })

