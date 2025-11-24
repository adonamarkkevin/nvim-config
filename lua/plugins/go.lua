return {
    {
        "ray-x/go.nvim",
        dependencies = {
            "ray-x/guihua.lua",
            "neovim/nvim-lspconfig",
            "nvim-treesitter/nvim-treesitter",
        },
        config = function()
            require("go").setup({
                -- Disable LSP config since we configure gopls in lspconfig.lua
                lsp_cfg = false,
                lsp_gofumpt = true,
                lsp_on_attach = false,
                -- Disable LSP keybindings since we have them in lspconfig.lua
                lsp_keymaps = false,
                -- Enable diagnostic display
                diagnostic = {
                    hdlr = false,
                    underline = true,
                    virtual_text = { spacing = 0, prefix = "■" },
                    signs = true,
                    update_in_insert = false,
                },
                -- Auto-import on save
                lsp_inlay_hints = {
                    enable = true,
                    style = "inlay",
                },
                -- Test settings
                run_in_floaterm = true,
                test_runner = "go",
                verbose_tests = true,
                -- Icons
                icons = { breakpoint = "🔴", currentpos = "🔶" },
                -- Trouble integration
                trouble = true,
                -- Tag options
                tag_transform = false,
                tag_options = "json=omitempty",
            })

            -- Auto-import on save
            vim.api.nvim_create_autocmd("BufWritePre", {
                pattern = "*.go",
                callback = function()
                    require("go.format").goimport()
                end,
            })

            -- Go-specific keybindings
            local keymap = vim.keymap.set
            local opts = { noremap = true, silent = true }

            -- Code generation
            keymap("n", "<leader>gfs", "<cmd>GoFillStruct<cr>", vim.tbl_extend("force", opts, { desc = "Fill struct" }))
            keymap("n", "<leader>gfs", "<cmd>GoFillSwitch<cr>", vim.tbl_extend("force", opts, { desc = "Fill switch" }))
            keymap("n", "<leader>gif", "<cmd>GoIfErr<cr>", vim.tbl_extend("force", opts, { desc = "Generate if err" }))

            -- Struct tags
            keymap(
                "n",
                "<leader>gtj",
                "<cmd>GoAddTag json<cr>",
                vim.tbl_extend("force", opts, { desc = "Add json tags" })
            )
            keymap(
                "n",
                "<leader>gty",
                "<cmd>GoAddTag yaml<cr>",
                vim.tbl_extend("force", opts, { desc = "Add yaml tags" })
            )
            keymap("n", "<leader>gtr", "<cmd>GoRmTag<cr>", vim.tbl_extend("force", opts, { desc = "Remove tags" }))

            -- Tests
            keymap("n", "<leader>gt", "<cmd>GoTest<cr>", vim.tbl_extend("force", opts, { desc = "Run Go tests" }))
            keymap(
                "n",
                "<leader>gT",
                "<cmd>GoTestFunc<cr>",
                vim.tbl_extend("force", opts, { desc = "Test current function" })
            )
            keymap(
                "n",
                "<leader>gC",
                "<cmd>GoCoverage<cr>",
                vim.tbl_extend("force", opts, { desc = "Show test coverage" })
            )
            keymap(
                "n",
                "<leader>gcc",
                "<cmd>GoCoverageClear<cr>",
                vim.tbl_extend("force", opts, { desc = "Clear coverage" })
            )

            -- Code actions
            keymap(
                "n",
                "<leader>gim",
                "<cmd>GoImpl<cr>",
                vim.tbl_extend("force", opts, { desc = "Implement interface" })
            )

            -- Linting (custom implementation to avoid golangci-lint version issues)
            keymap("n", "<leader>gl", function()
                vim.cmd("terminal golangci-lint run")
            end, vim.tbl_extend("force", opts, { desc = "Run golangci-lint" }))

            -- Module management
            keymap("n", "<leader>gmt", "<cmd>GoModTidy<cr>", vim.tbl_extend("force", opts, { desc = "go mod tidy" }))

            -- Comments
            keymap("n", "<leader>gcm", "<cmd>GoCmt<cr>", vim.tbl_extend("force", opts, { desc = "Generate comment" }))
        end,
        event = { "CmdlineEnter" },
        ft = { "go", "gomod" },
        build = ':lua require("go.install").update_all_sync()',
    },
}
