return {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons",
        "muniftanjim/nui.nvim",
    },
    config = function()
        require("neo-tree").setup({
            filesystem = {
                filtered_items = {
                    hide_dotfiles = false,              -- show dotfiles
                    hide_hidden = false,                -- show hidden files
                },
                follow_current_file = { enabled = true }, -- expand and focus on current file
                use_libuv_file_watcher = true           -- enables file system watcher
            },
        })

        -- Key mappings for Neo-tree
        vim.keymap.set("n", "<c-n>", ":Neotree filesystem reveal left<cr>", {})
        vim.keymap.set("n", "<leader>bf", ":Neotree buffers reveal float<cr>", {})
    end,
}
