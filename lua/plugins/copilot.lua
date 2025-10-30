return {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    config = function()
        require("copilot").setup({
            suggestion = { enabled = false },
            panel = { enabled = false },
            server_opts_overrides = {
                -- Enable the LSP for sidekick.nvim
                settings = {
                    advanced = {
                        listCount = 10,
                        inlineSuggestCount = 3,
                    },
                },
            },
        })

        -- Enable Copilot LSP
        vim.lsp.enable("copilot")
    end,
}
