return {
    "lewis6991/gitsigns.nvim",
    config = function()
        require('gitsigns').setup()

        vim.keymap.set('n', '<leader>hs', ":Gitsigns stage_hunk<CR>", {})
        vim.keymap.set('n', '<leader>hr', ":Gitsigns reset_hunk<CR>", {})
        vim.keymap.set("n", "<leader>hp", ":Gitsigns preview_hunk<CR>", {})

        local function diffthis_vertical()
            require('gitsigns').diffthis(nil, { vertical = true })
        end
        vim.keymap.set('n', '<leader>hd', diffthis_vertical, {})
    end
}