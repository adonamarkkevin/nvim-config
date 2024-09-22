return {
    "windwp/nvim-autopairs",
    config = function()
        require("nvim-autopairs").setup({
            check_ts = true, -- Enable treesitter integration for better pairing
        })
    end,
}
