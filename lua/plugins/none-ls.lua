return {
    "nvimtools/none-ls.nvim",
    config = function()
        local null_ls = require("null-ls")

        -- Set up null-ls with desired sources
        null_ls.setup({
            sources = {
                null_ls.builtins.formatting.stylua.with({
                    extra_filetypes = { "lua" },
                    extra_args = { "--indent-type", "Spaces", "--indent-width", "4" },
                }),
                null_ls.builtins.formatting.prettier.with({
                    extra_filetypes = { "typescript", "typescriptreact" },
                }),
                null_ls.builtins.diagnostics.erb_lint,
            },
        })

        -- Set up auto-formatting on save
        local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
        vim.api.nvim_create_autocmd("BufWritePre", {
            group = augroup,
            pattern = "*",
            callback = function()
                vim.lsp.buf.format({ async = false })
            end,
        })
    end,
}
