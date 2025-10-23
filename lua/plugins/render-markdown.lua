return {
	"MeanderingProgrammer/render-markdown.nvim",
	dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
	opts = {},
	config = function()
		require("render-markdown").setup({})

		-- Keymaps
		vim.keymap.set("n", "<leader>mdt", "<cmd>RenderMarkdown toggle<CR>", { desc = "Toggle markdown rendering" })
		vim.keymap.set("n", "<leader>mde", "<cmd>RenderMarkdown enable<CR>", { desc = "Enable markdown rendering" })
		vim.keymap.set("n", "<leader>mdd", "<cmd>RenderMarkdown disable<CR>", { desc = "Disable markdown rendering" })
	end,
}
