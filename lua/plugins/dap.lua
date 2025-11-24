return {
    {
        "mfussenegger/nvim-dap",
        dependencies = {
            "rcarriga/nvim-dap-ui",
            "nvim-neotest/nvim-nio",
            "theHamsta/nvim-dap-virtual-text",
            "leoluz/nvim-dap-go",
        },
        config = function()
            local dap = require("dap")
            local dapui = require("dapui")

            -- Setup dap-ui
            dapui.setup()

            -- Setup virtual text for variables during debugging
            require("nvim-dap-virtual-text").setup()

            -- Setup Go debugging with delve
            require("dap-go").setup({
                dap_configurations = {
                    {
                        type = "go",
                        name = "Attach remote",
                        mode = "remote",
                        request = "attach",
                    },
                },
                delve = {
                    path = "dlv",
                    initialize_timeout_sec = 20,
                    port = "${port}",
                    args = {},
                    build_flags = "",
                },
            })

            -- Automatically open/close dap-ui
            dap.listeners.before.attach.dapui_config = function()
                dapui.open()
            end
            dap.listeners.before.launch.dapui_config = function()
                dapui.open()
            end
            dap.listeners.before.event_terminated.dapui_config = function()
                dapui.close()
            end
            dap.listeners.before.event_exited.dapui_config = function()
                dapui.close()
            end

            -- Keybindings for debugging
            vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, { desc = "Toggle breakpoint" })
            vim.keymap.set("n", "<leader>dc", dap.continue, { desc = "Continue/Start debugging" })
            vim.keymap.set("n", "<leader>di", dap.step_into, { desc = "Step into" })
            vim.keymap.set("n", "<leader>do", dap.step_over, { desc = "Step over" })
            vim.keymap.set("n", "<leader>dO", dap.step_out, { desc = "Step out" })
            vim.keymap.set("n", "<leader>dr", dap.repl.open, { desc = "Open REPL" })
            vim.keymap.set("n", "<leader>dl", dap.run_last, { desc = "Run last" })
            vim.keymap.set("n", "<leader>dt", dapui.toggle, { desc = "Toggle DAP UI" })
            vim.keymap.set("n", "<leader>dx", dap.terminate, { desc = "Terminate debugging" })

            -- Go-specific debug keybindings
            vim.keymap.set("n", "<leader>dgt", require("dap-go").debug_test, { desc = "Debug Go test" })
            vim.keymap.set("n", "<leader>dgl", require("dap-go").debug_last_test, { desc = "Debug last Go test" })
        end,
    },
}
