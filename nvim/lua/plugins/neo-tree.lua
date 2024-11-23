return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
    "MunifTanjim/nui.nvim",
  },
  config = function()
    require('neo-tree').setup({
      window = {
        position = "left",
        width = 30,
        auto_resize_width = true,
      },
    })

		vim.keymap.set("n", "<C-n>", ":Neotree filesystem reveal<CR>", {})
		vim.keymap.set("n", "<leader>bf", ":Neotree buffers reveal float<CR>", {})
    vim.keymap.set("n", "<leader>gs", ":Neotree git_status reveal<CR>", {})
  end
}
