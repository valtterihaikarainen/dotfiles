-- Refer to :help option-list for availble options
-- See all current options with :set all

vim.opt.encoding = "utf-8" -- set enconding
vim.opt.nu = true -- enable line numbers
vim.opt.relativenumber = true -- relative line numbers

-- TAB BEHAVIOUR AND AUTOINDENT
vim.opt.expandtab = true -- convert tabs to spaces
vim.opt.tabstop = 4 -- how many spaces to render for each 'tab' \t character
vim.opt.softtabstop = 4  -- deteach "tab" press is 4 spaces when used with expandtab
vim.opt.shiftwidth = 4 -- determines the number of spaces to use for each (auto)indentation
vim.opt.autoindent = true -- auto indendation

-- INSIDE FILE SEARCH 
vim.opt.ignorecase = true -- ignore case when searching
vim.opt.smartcase = true -- unless capital letter in search
vim.opt.hlsearch = false -- do no highlight all matches on previous search pattern
vim.opt.incsearch = true -- incrementally highlight searches as you type

-- COLOR SUPPORT
vim.opt.termguicolors = true -- enable true color support

-- SCROLLING BEHAVIOUR
vim.opt.scrolloff = 8 -- minimum number of lines to keep above and below the cursor
vim.opt.sidescrolloff = 8 -- minimum number of lines to keep above and below the cursor

-- SET CLIPBOARD AS DEFAULT REGISTER
vim.opt.clipboard = "unnamedplus"

