return {
    "nvimtools/none-ls.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
    },
    config = function()
        local null_ls = require("null-ls")

        -- Set up null-ls with desired sources
        null_ls.setup({
            sources = {
                null_ls.builtins.formatting.stylua,
                null_ls.builtins.formatting.prettier.with({
                    prefer_local = "node_modules/.bin",
                }),
                null_ls.builtins.diagnostics.erb_lint,
            },
        })

        -- Set up auto-formatting on save
        local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
        vim.api.nvim_create_autocmd("BufWritePre", {
            group = augroup,
            pattern = "*",
            callback = function(args)
                -- Save the view to preserve cursor position
                local view = vim.fn.winsaveview()

                vim.lsp.buf.format({
                    async = false,
                    bufnr = args.buf,
                    filter = function(client)
                        -- Only use null-ls for formatting
                        return client.name == "null-ls"
                    end,
                })

                -- Restore the view
                vim.fn.winrestview(view)
            end,
        })
    end,
}
