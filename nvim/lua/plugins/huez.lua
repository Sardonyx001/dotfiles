return {
  -- About Theme picker/manager
  "vague2k/huez.nvim",
  -- if you want registry related features, uncomment this
  import = "huez-manager.import",
  branch = "stable",
  event = "UIEnter",
  keys = {
    {
      "<leader>co",
      function()
        require("huez.pickers").themes()
      end,
      desc = "Select Theme (Local)",
    },
    {
      "<leader>cl",
      function()
        require("huez.pickers").live()
      end,
      desc = "Select Theme (Live)",
    },
  },
  config = function()
    require("huez").setup({})
  end,
}
