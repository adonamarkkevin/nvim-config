return {
    "jackMort/ChatGPT.nvim",
    event = "VeryLazy",
    config = function()
        require("chatgpt").setup({
            api_key_cmd = "pass show api/tokens/openai",
            openai_params = {
                model = "gpt-4o"
            }
        })
        vim.keymap.set('n', '<leader>sk', ":ChatGPT<CR>", {})
    end,
    dependencies = {
        "MunifTanjim/nui.nvim",
        "nvim-lua/plenary.nvim",
        "folke/trouble.nvim",
        "nvim-telescope/telescope.nvim"
    },
}
