return {
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = function()
            local config = require("nvim-treesitter.configs")
            config.setup({
                ensure_installed = {
                    "lua",
                    "markdown",
                    "markdown_inline",
                    "go",
                    "gomod",
                    "gosum",
                    "gowork",
                    "html",
                    "json",
                    "jsdoc",
                    "tsx",
                    "typescript",
                    "javascript",
                    "graphql",
                    "sql",
                },
                auto_install = true,
                highlight = {
                    enable = true,
                    disable = { "markdown", "markdown_inline" },
                },
                indent = { enable = true },
            })
        end,
    },
}
