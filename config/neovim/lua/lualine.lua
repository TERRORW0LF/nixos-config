require('lualine').setup({
    sections = {
        lualine_x = {
            function()
                return require('direnv').statusline()
            end,
            'encoding',
            'fileformat',
            'filetype',
        },
    },
})