return {
    {
        "nvim-neotest/neotest",
        dependencies = {
            "nvim-neotest/nvim-nio",
            "nvim-lua/plenary.nvim",
            "antoinemadec/FixCursorHold.nvim",
            "nvim-treesitter/nvim-treesitter",
            "nvim-neotest/neotest-go",
        },
        config = function()
            require("neotest").setup({
                adapters = {
                    require("neotest-go")({
                        experimental = {
                            test_table = true,
                        },
                        args = { "-count=1", "-timeout=60s", "-race", "-cover" },
                    }),
                },
                -- Floating window for test output
                output = {
                    enabled = true,
                    open_on_run = "short",
                },
                -- Show test status in the sign column
                status = {
                    enabled = true,
                    virtual_text = false,
                    signs = true,
                },
                -- Test summary window configuration
                summary = {
                    enabled = true,
                    expand_errors = true,
                    follow = true,
                    mappings = {
                        attach = "a",
                        expand = { "<CR>", "<2-LeftMouse>" },
                        expand_all = "e",
                        jumpto = "i",
                        output = "o",
                        run = "r",
                        short = "O",
                        stop = "u",
                    },
                },
            })

            -- Neotest keybindings
            local keymap = vim.keymap.set
            local opts = { noremap = true, silent = true }

            keymap(
                "n",
                "<leader>tt",
                "<cmd>lua require('neotest').run.run()<cr>",
                vim.tbl_extend("force", opts, { desc = "Run nearest test" })
            )
            keymap(
                "n",
                "<leader>tf",
                "<cmd>lua require('neotest').run.run(vim.fn.expand('%'))<cr>",
                vim.tbl_extend("force", opts, { desc = "Run tests in file" })
            )
            keymap(
                "n",
                "<leader>td",
                "<cmd>lua require('neotest').run.run({strategy = 'dap'})<cr>",
                vim.tbl_extend("force", opts, { desc = "Debug nearest test" })
            )
            keymap(
                "n",
                "<leader>ts",
                "<cmd>lua require('neotest').summary.toggle()<cr>",
                vim.tbl_extend("force", opts, { desc = "Toggle test summary" })
            )
            keymap(
                "n",
                "<leader>to",
                "<cmd>lua require('neotest').output.open({ enter = true })<cr>",
                vim.tbl_extend("force", opts, { desc = "Show test output" })
            )
            keymap(
                "n",
                "<leader>tO",
                "<cmd>lua require('neotest').output_panel.toggle()<cr>",
                vim.tbl_extend("force", opts, { desc = "Toggle output panel" })
            )
            keymap(
                "n",
                "<leader>tS",
                "<cmd>lua require('neotest').run.stop()<cr>",
                vim.tbl_extend("force", opts, { desc = "Stop test" })
            )
            keymap(
                "n",
                "[t",
                "<cmd>lua require('neotest').jump.prev({ status = 'failed' })<cr>",
                vim.tbl_extend("force", opts, { desc = "Jump to previous failed test" })
            )
            keymap(
                "n",
                "]t",
                "<cmd>lua require('neotest').jump.next({ status = 'failed' })<cr>",
                vim.tbl_extend("force", opts, { desc = "Jump to next failed test" })
            )
        end,
    },
}
