
vim.api.nvim_create_autocmd('TermOpen', {
    group = vim.api.nvim_create_augroup('custom-term-open', {clear = true}),
    callback = function()
    vim.opt.number = false
    vim.opt.relativenumber = false
    end,
})

vim.keymap.set('n', '<leader>st', function()
    vim.cmd.new()
    vim.cmd.terminal()
    vim.cmd.wincmd('J')
    vim.api.nvim_win_set_height(0, 10)
end, { noremap = true, silent = true, desc = "Open vertical split terminal" })
