return {
    "nvimtools/none-ls.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
    },
    config = function()
        local null_ls = require("null-ls")
        local h = require("null-ls.helpers")

        -- Custom mbake formatter for Makefiles
        local mbake = h.make_builtin({
            name = "mbake",
            meta = {
                url = "https://github.com/EbodShojaei/bake",
                description = "Makefile formatter and linter",
            },
            method = null_ls.methods.FORMATTING,
            filetypes = { "make" },
            generator_opts = {
                command = "sh",
                args = { "-c", "mbake format --stdin 2>/dev/null || cat" },
                to_stdin = true,
            },
            factory = h.formatter_factory,
        })

        -- Set up null-ls with desired sources
        null_ls.setup({
            sources = {
                null_ls.builtins.formatting.stylua,
                null_ls.builtins.formatting.prettier.with({
                    prefer_local = "node_modules/.bin",
                }),
                null_ls.builtins.diagnostics.erb_lint,
                -- Go formatters
                null_ls.builtins.formatting.goimports,
                null_ls.builtins.formatting.gofumpt,
                -- Go linters (golangci-lint includes staticcheck, stylecheck, simple, and 50+ others)
                null_ls.builtins.diagnostics.golangci_lint,
                null_ls.builtins.code_actions.gomodifytags,
                null_ls.builtins.code_actions.impl,
                -- Makefile formatter (checkmake linter disabled - too strict for CI/CD Makefiles)
                mbake,
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
