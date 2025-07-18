return {
  -- tokyonight
  -- {
  --   "folke/tokyonight.nvim",
  --   opts = {
  --     transparent = true,
  --     styles = {
  --       sidebars = "transparent",
  --       floats = "transparent",
  --     },
  --   },
  -- },
  -- catppuccin
  {
    "catppuccin/nvim",
    lazy = true,
    name = "catppuccin",
    -- you can do it like this with a config function
    config = function()
      require("catppuccin").setup({
        transparent_background = true,
        dim_inactive = {
          enabled = false, -- dims the background color of inactive window
          shade = "dark",
          percentage = 0.15, -- percentage of the shade to apply to the inactive window
        },
      })
    end,
    -- or just use opts table
    opts = {
      -- configurations
    },
  },
  -- {
  --   "sainnhe/everforest",
  --   lazy = false,
  --   name = "everforest",
  --   priority = 1000,
  --   config = function()
  --     -- Optionally configure and load the colorscheme
  --     -- directly inside the plugin declaration.
  --     vim.g.everforest_enable_italic = true
  --     vim.cmd.colorscheme("everforest")
  --   end,
  -- },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin",
    },
  },
}
