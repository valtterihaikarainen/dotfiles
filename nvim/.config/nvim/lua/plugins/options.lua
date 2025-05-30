vim.cmd("colorscheme gruvbox") -- set color theme

-- ensure auto-session restores local options (filetypes, highlights, etc.)
vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"
vim.opt.termguicolors = true --bufferline
require("bufferline").setup{} --bufferline


