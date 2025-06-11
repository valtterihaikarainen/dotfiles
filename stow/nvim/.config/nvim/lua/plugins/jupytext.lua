return {
  {
    "goerz/jupytext.nvim",
    version = "0.2.0",
    ft = { "ipynb", "markdown", "python", "rmd", "qmd" },
    event = { "BufReadCmd *.ipynb", "BufWriteCmd *.ipynb" },
    -- delay the require until load time:
    config = function()
      local j = require("jupytext")
      j.setup({
        jupytext           = "jupytext",
        format             = "markdown",
        update             = true,
        filetype           = j.get_filetype,
        new_template       = j.default_new_template(),
        sync_patterns      = { "*.md", "*.py", "*.jl", "*.R", "*.Rmd", "*.qmd" },
        autosync           = true,
        handle_url_schemes = true,
      })
    end,
  },
}
