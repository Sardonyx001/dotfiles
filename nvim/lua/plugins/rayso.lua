return {
  "TobinPalmer/rayso.nvim",
  cmd = "Rayso",
  opts = {
    base_url = "https://ray.so/", -- Default URL
    open_cmd = "Chrome", -- Command to open the screenshot in a browser.
    options = {
      background = true, -- If the screenshot should have a background.
      dark_mode = true, -- If the screenshot should be in dark mode.
      logging_enabled = false, -- If you enable the logging file.
      padding = 16, -- The default padding that the screenshot will have.
      theme = "crimson", -- Theme
      title = " ", -- Title of the screenshot (keep empty for no title).
    },
  },
  keys = {
    { "<leader>rs", "<cmd>Rayso<cr>", desc = "Share with Rayso" },
  },
}
