return {
    "nvim-treesitter/nvim-treesitter-context",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    config = function()
        require("treesitter-context").setup({
            enable = true,
            max_lines = 3,
            min_window_height = 10,
            mode = "cursor",
            separator = "─",
        })

        vim.api.nvim_create_autocmd("FileType", {
            pattern = "markdown",
            callback = function()
                require("treesitter-context").disable()
            end,
        })
    end,
}
