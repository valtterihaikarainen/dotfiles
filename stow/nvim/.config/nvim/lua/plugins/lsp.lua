return {
    {
        'VonHeikemen/lsp-zero.nvim', 
        branch = 'v3.x',
        lazy = true,
        config = false,
        init = function()
            vim.g.lsp_zero_extend_cmp = 0
            vim.g.lsp_zero_extend_lspconfig = 0
        end,
    },
    
    -- Autocompletion
    {
        'hrsh7th/nvim-cmp',
        event = 'InsertEnter',
        dependencies = {
            {'L3MON4D3/LuaSnip'},
        },
        config = function()
          -- Here is where you configure the autocompletion settings.
          local lsp_zero = require('lsp-zero')
          lsp_zero.extend_cmp()

          -- And you can configure cmp even more, if you want to.
          local cmp = require('cmp')
          local cmp_action = lsp_zero.cmp_action()

          cmp.setup({
            formatting = lsp_zero.cmp_format({details = true}),
            mapping = cmp.mapping.preset.insert({
              ['<C-Space>'] = cmp.mapping.complete(),
              ['<C-u>'] = cmp.mapping.scroll_docs(-4),
              ['<C-d>'] = cmp.mapping.scroll_docs(4),
              ['<C-f>'] = cmp_action.luasnip_jump_forward(),
              ['<C-b>'] = cmp_action.luasnip_jump_backward(),
              ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
              ['<Tab>'] = cmp.mapping.select_next_item(),
              ['<S-Tab>'] = cmp.mapping.select_prev_item(),
            })
          })
        end
      },
    -- LSP

    {
        'williamboman/mason.nvim',
        lazy = false,
        config = true,
    },
    {
        'neovim/nvim-lspconfig',
        cmd = {'LspInfo', 'LspInstall', 'LspStart'},
        event = {'BufReadPre', 'BufNewFile'},
        dependencies = {
          {'hrsh7th/cmp-nvim-lsp'},
          {'williamboman/mason-lspconfig.nvim'},
        },
        config = function()
            local lsp_zero = require('lsp-zero')
            lsp_zero.extend_lspconfig()
            lsp_zero.on_attach(function(client, bufnr)
                lsp_zero.default_keymaps({buffer = bufnr})
            end)
        require('mason-lspconfig').setup({
            ensure_installed = {
                'pyright',
                'clangd',
                'bashls',
                'lua_ls',
            },
            handlers = {
                lsp_zero.default_setup,
                lua_ls = function()
                    local lua_opts = lsp_zero.nvim_lua_ls()

                    lua_opts.settings = {
                        Lua = {
                            diagnostics = {
                                globals = { "vim" }, 
                            }, 
                            workspace = {
                                checkThirdParty = false, 
                                library = vim.api.nvim_get_runtime_file("", true), 
                            }
                        }
                    }

                    require('lspconfig').lua_ls.setup(lua_opts)
                end,
            }
        })
        end,
    }
}
