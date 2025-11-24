return {
    "mfussenegger/nvim-lint",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
        local lint = require("lint")

        -- Configure golangci-lint for Go files
        lint.linters_by_ft = {
            go = { "golangcilint" },
        }

        -- Customize golangci-lint to work properly
        lint.linters.golangcilint.args = {
            "run",
            "--out-format",
            "json",
            "--show-stats=false",
            "--print-issued-lines=false",
            "--print-linter-name=true",
        }

        -- Auto-lint on specific events
        local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

        vim.api.nvim_create_autocmd({ "BufWritePost" }, {
            group = lint_augroup,
            pattern = "*.go",
            callback = function()
                -- Only lint if golangci-lint is available
                if vim.fn.executable("golangci-lint") == 1 then
                    lint.try_lint()
                end
            end,
        })

        -- Manual lint trigger
        vim.keymap.set("n", "<leader>ll", function()
            lint.try_lint()
        end, { desc = "Trigger linting for current file" })

        -- Show diagnostics info
        vim.keymap.set("n", "<leader>ld", function()
            vim.diagnostic.open_float()
        end, { desc = "Show line diagnostics" })
    end,
}
