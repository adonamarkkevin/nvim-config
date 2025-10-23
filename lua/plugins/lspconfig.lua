return {
    {
        "williamboman/mason.nvim",
        lazy = false,
        config = function()
            require("mason").setup()
        end,
    },
    {
        "williamboman/mason-lspconfig.nvim",
        lazy = false,
        opts = {
            auto_install = true,
        },
    },
    {
        "neovim/nvim-lspconfig",
        lazy = false,
        config = function()
            local capabilities = require("cmp_nvim_lsp").default_capabilities()

            -- Set up keymaps when LSP attaches
            vim.api.nvim_create_autocmd("LspAttach", {
                callback = function(args)
                    local bufnr = args.buf
                    local opts = { buffer = bufnr, noremap = true, silent = true }
                    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
                    vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, opts)
                    vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references, opts)
                    vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
                end,
            })

            -- Set default capabilities for all LSP servers
            vim.lsp.config("*", {
                capabilities = capabilities,
            })

            -- Enable LSP servers (uses defaults from nvim-lspconfig)
            vim.lsp.enable("ts_ls")
            vim.lsp.enable("gopls")
            vim.lsp.enable("html")
            vim.lsp.enable("lua_ls")
            vim.lsp.enable("sqlls")
        end,
    },
}
