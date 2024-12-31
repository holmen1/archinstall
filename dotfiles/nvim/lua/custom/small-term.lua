
vim.api.nvim_create_autocmd('TermOpen', {
    group = vim.api.nvim_create_augroup('custom-term-open', {clear = true}),
    callback = function()
    vim.opt.number = false
    vim.opt.relativenumber = false
    end,
})

local job_id = 0
vim.keymap.set('n', '<leader>st', function()
    vim.cmd.new()
    vim.cmd.terminal()
    vim.cmd.wincmd('J')
    vim.api.nvim_win_set_height(0, 10)

    job_id = vim.bo.channel
end, { noremap = true, silent = true, desc = "Open vertical split terminal" })


vim.keymap.set('n', '<leader>mats', function()
    vim.fn.chansend(job_id, { "ls\r\n" })
end)

vim.keymap.set('n', '<leader>run', function()
    local filename = vim.fn.expand('%')
    if job_id ~= 0 then
        vim.fn.chansend(job_id, { "stack runhaskell " .. filename .. "\r\n" })
    else
        print("No terminal session active")
    end
end, { noremap = true, silent = true, desc = "runhaskell" })
