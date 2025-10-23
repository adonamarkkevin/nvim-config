return {
    {
        "iamcco/markdown-preview.nvim",
        cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
        ft = { "markdown" },
        build = "cd app && npm install",
        keys = {
            { "<leader>md", "<cmd>MarkdownPreview<cr>", desc = "Markdown Preview" },
        },
        config = function()
            -- Set to 1 to open preview in browser automatically when entering markdown buffer
            vim.g.mkdp_auto_start = 0

            -- Set to 1 to auto close preview when switching to another buffer
            vim.g.mkdp_auto_close = 1

            -- Set to 1 to refresh preview on save or leaving insert mode
            vim.g.mkdp_refresh_slow = 0

            -- Browser to use, default will use system default browser
            vim.g.mkdp_browser = ""

            -- Preview server port (default: random)
            vim.g.mkdp_port = ""

            -- Theme for preview: 'dark' or 'light'
            vim.g.mkdp_theme = "dark"
        end,
    },
}
