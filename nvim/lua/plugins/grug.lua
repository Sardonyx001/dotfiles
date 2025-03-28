return {
  "MagicDuck/grug-far.nvim",
  opts = { headerMaxWidth = 80 },
  cmd = "GrugFar",
  keys = {
    -- Search/Replace in current working buffer (cwb)
    {
      "<leader>sr",
      function()
        local grug = require("grug-far")
        grug.open({
          transient = true,
          prefills = { paths = vim.fn.expand("%") },
        })
      end,
      mode = { "n", "v" },
      desc = "Search/Replace (cwb)",
    },
    -- Search/Replace in multiple files
    {
      "<leader>sR",
      function()
        local grug = require("grug-far")
        local ext = vim.bo.buftype == "" and vim.fn.expand("%:e")
        grug.open({
          transient = true,
          prefills = {
            filesFilter = ext and ext ~= "" and "*." .. ext or nil,
          },
        })
      end,
      mode = { "n", "v" },
      desc = "Search/Replace (gen)",
    },
  },
}
