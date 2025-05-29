return{
  {
    "catppuccin/nvim", name = "catppuccin", priority = 1000,
    config = function()
      -- load the colorscheme here
      vim.cmd([[colorscheme catppuccin-macchiato]])
    end,
    opts = {transparent_background = true,},
  },
}
