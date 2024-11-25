vim.cmd("set tabstop=2")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=2")
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Enable relative line numbering
vim.wo.number = true
vim.wo.relativenumber = true

require("config.lazy")
