return {
    "nvim-treesitter/nvim-treesitter-context",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    config = function()
        require("treesitter-context").setup({
            enable = true, -- Enable this plugin
            max_lines = 3, -- How many lines to show at the top
            min_window_height = 10, -- Only show if window is tall enough
            mode = "cursor", -- "cursor" keeps the current function visible
            separator = "─", -- Adds a line separator
        })
    end,
}
