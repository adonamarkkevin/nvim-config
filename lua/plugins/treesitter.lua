return {
    {
        "nvim-treesitter/nvim-treesitter",
        branch = "main",
        lazy = false,
        build = ":TSUpdate",
        config = function()
            local parsers = {
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
            }

            require("nvim-treesitter").install(parsers)

            local filetypes = {
                "lua",
                "go",
                "gomod",
                "gosum",
                "gowork",
                "html",
                "json",
                "typescriptreact",
                "typescript",
                "javascript",
                "graphql",
                "sql",
            }

            vim.api.nvim_create_autocmd("FileType", {
                pattern = filetypes,
                callback = function()
                    vim.treesitter.start()
                    vim.wo[0][0].foldmethod = "expr"
                    vim.wo[0][0].foldexpr = "v:lua.vim.treesitter.foldexpr()"
                    vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
                end,
            })
        end,
    },
}
