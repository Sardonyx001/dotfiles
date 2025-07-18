return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    require("lualine").setup()
  end,
  opts = function(_, opts)
    if not vim.g.trouble_lualine then
      table.insert(opts.sections.lualine_c, { "navic", color_correction = "dynamic" })
    end
  end,
}
