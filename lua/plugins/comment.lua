return {
    "terrortylor/nvim-comment",
    config = function()
        require('nvim_comment').setup({
            -- enable or disable the creation of default mappings
            create_mappings = true,

            -- LHS of toggle mapping in NORMAL + VISUAL mode
            line_mapping = "<leader>/",
            operator_mapping = "<leader>/",

            -- whether to create basic (operator-pending) and extra mappings for NORMAL + VISUAL mode
            comment_empty = false,
        })

        -- optional: you can set up an autocommand group for custom behavior
        local comment_augroup = vim.api.nvim_create_augroup("CommentGroup", {})

        -- example: automatically trim trailing whitespace before commenting
        vim.api.nvim_create_autocmd("BufWritePre", {
            group = comment_augroup,
            pattern = "*",
            command = "%s/\\s\\+$//e",
        })
    end,
}
