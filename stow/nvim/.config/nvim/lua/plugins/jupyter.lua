return {
    {
        "benlubas/molten-nvim",   
        version = "^1.0.0"
        dependencies = { "3rd/image.nvim" },
        build = ":UpdateRemotePlugins",
        init = function ()
            -- these are examples not defaults. Check molten readme at: https://github.com/benlubas/molten-nvim
            vim.g.molgen_image_provider = "image.nvim"
            vim.g.molgen_output_win_max_height = "image.nvim"
        end,
    }, 
    {
        -- see the image.nvim readme for more information about the plugin
        "3rd/image.nvim", 
        opts = {
            backend = "kitty",
            max_width = 100,
            max_height = 12,
            max_height_window_percentage = math.huge,
            max_width_window_percentage = math.huge,
            window_overlap_clear_enables = true,
            window_overlap_clear_ft_ignore = { "cmp_menu", "cmp_docs", ""},
        }
    }
}
