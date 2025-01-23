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
            window = {
                width = 90,
            },
            filesystem = {
                filtered_items = {
                    hide_dotfiles = false, -- show dotfiles
                    hide_hidden = false, -- show hidden files
                },
                follow_current_file = { enabled = true }, -- expand and focus on current file
                use_libuv_file_watcher = true, -- enables file system watcher
            },
        })

        -- Key mappings for Neo-tree with toggle functionality
        vim.keymap.set("n", "<c-n>", function()
            -- Check if Neo-tree is currently open by looking for any window with "neo-tree"
            local neo_tree_open = false
            for _, win in ipairs(vim.api.nvim_list_wins()) do
                local bufname = vim.api.nvim_buf_get_name(vim.api.nvim_win_get_buf(win))
                if bufname:match("neo%-tree") then
                    neo_tree_open = true
                    break
                end
            end

            if neo_tree_open then
                vim.cmd("Neotree close") -- Close Neo-tree if it's open
            else
                vim.cmd("Neotree filesystem reveal right") -- Open Neo-tree if it's not open
            end
        end, { noremap = true, silent = true })

        -- Key mapping for buffers in float mode
        vim.keymap.set("n", "<leader>bf", ":Neotree buffers reveal right<cr>", {})
    end,
}
