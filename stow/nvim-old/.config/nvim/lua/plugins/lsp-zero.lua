

local lsp_zero = require("lsp-zero")

-- Tell lsp-zero to extend cmp and lspconfig for us
lsp_zero.extend_cmp()
lsp_zero.extend_lspconfig()

-- When an LSP server atttaches, apply default keymaps from lsp-zero
lsp_zero.on_attach(function(client, bufnr)
  lsp_zero.default_keymaps( { buffer = bufnr } )
end)

-- Set up mason-lspconfig to ensure certain serveres are installed 
require("mason-lspconfig").setup({
  ensure_installed = { 
    "pyright",
    "ts_ls", 
    "clang",
    "bashls",
  },
  handlers = {
    -- Default handler (for most servers):
    lsp_zero.default.setup,
    -- Special config ffor lua_ls (Neovim's Lua lanaguage server)
    lua_ls = function ()
      local lua_opts = lsp_zero.nvim_lua_ls()
      require"lspconfig").lua_ls.setup(lua_opts)
    end, 
  }
})
