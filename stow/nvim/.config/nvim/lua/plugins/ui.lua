return {
    -- Theme
    {
        "gruvbox-community/gruvbox", 
        lazy = false,
        priority = 1000,
        config = function()
            vim.cmd("colorscheme gruvbox")
        end,
    },
    {
        'akinsho/bufferline.nvim',
        lazy = false,
        version = "*",
        dependencies = 'nvim-tree/nvim-web-devicons'
    } 
}
