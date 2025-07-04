return {
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = function()
            local config = require("nvim-treesitter.configs")
            config.setup({
                ensure_installed = {
                    "lua",
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
                highlight = { enable = true },
                indent = { enable = true },
            })
        end,
    },
}
