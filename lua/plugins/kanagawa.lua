return {
  'rebelot/kanagawa.nvim',
  config = function()
    require('kanagawa').setup({
      -- Optional: Customize the theme here if needed
      transparent = true,  -- Disable transparent background if you want
      globalStatus = true, -- Use global statusline
    })
    -- Load the Kanagawa theme
    vim.cmd('colorscheme kanagawa')
  end
}
