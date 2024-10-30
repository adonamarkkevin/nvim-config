return {
    {
        "nvim-telescope/telescope-ui-select.nvim",
    },
    {
        "nvim-telescope/telescope.nvim",
        tag = "0.1.5",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            require("telescope").setup({
                defaults = {
                    vimgrep_arguments = {
                        "rg",
                        "--color=never",
                        "--no-heading",
                        "--with-filename",
                        "--line-number",
                        "--column",
                        "--smart-case",
                        "--hidden",
                        "--glob=!.git/", -- Exclude the .git directory
                    },
                    file_ignore_patterns = {
                        "node_modules", -- Add any other directories you want to ignore
                    },
                },
                pickers = {
                    find_files = {
                        hidden = true, -- This enables finding hidden files
                    },
                },
                extensions = {
                    ["ui-select"] = {
                        require("telescope.themes").get_dropdown({}),
                    },
                },
            })
            local builtin = require("telescope.builtin")
            vim.keymap.set("n", "<leader>ff", builtin.find_files, {}) --find files
            vim.keymap.set("n", "<leader>fw", builtin.live_grep, {}) --live grep
            vim.keymap.set("n", "<leader><leader>", builtin.oldfiles, {})
            require("telescope").load_extension("ui-select")
        end,
    },
}
