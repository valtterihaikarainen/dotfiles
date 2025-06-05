return {
    {
        'nvim-telescope/telescope.nvim',
        branch = '0.1.x', 
        cmd = "Telescope",
        dependencies = { 
            'nvim-lua/plenary.nvim', 
            { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' }
        },
        config = function()
            vim.keymap.set("n", "<leader>fd", require('telescope.builtin').find_files)
            vim.keymap.set(
              "n",
              "<leader>en",
              "<cmd>lua require('telescope.builtin').find_files({ cwd = vim.fn.stdpath('config') })<CR>"
            )
        end
    } 
}
