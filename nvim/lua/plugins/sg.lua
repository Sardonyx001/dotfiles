local function fuzzy_search_results()
  require("sg.extensions.telescope").fuzzy_search_results()
end

return {
  desc = "Sourcegraph",
  {
    "hrsh7th/nvim-cmp",
    opts = function(_, opts)
      local cmp = require("cmp")
      opts.sources = cmp.config.sources(vim.list_extend(opts.sources, {
        { name = "cody" },
      }))
    end,
  },
  {
    "sourcegraph/sg.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
    },
    lazy = false,
    opts = {
      on_attach = require("lazyvim.util").lsp.on_attach,
    },
    keys = {
      { "<leader>ai", "<cmd>CodyToggle<cr>", desc = "Cody toggle" },
      {
        "<leader>ad",
        function()
          local line = vim.fn.getline(".")
          local start = vim.fn.col(".")
          local finish = vim.fn.col("$")
          local text = line:sub(start, finish)
          vim.fn.setreg('"', text)
          vim.cmd([[CodyTask 'Write document for current context']])
        end,
        mode = "n",
        desc = "Generate Document with AI",
      },
      {
        "<leader>ac",
        ':CodyTask ""<Left>',
        mode = "n",
        desc = "Let AI Write Code",
      },
      {
        "<leader>as",
        "<cmd> lua require('sg.extensions.telescope').fuzzy_search_results()<CR>",
        mode = "n",
        desc = "AI Search",
      },
      -- v mode bindings
      {
        "<leader>ai",
        "y:CodyChat<CR><ESC>pG$a<CR>",
        mode = "v",
        desc = "Chat Selected Code",
      },
      {
        "<leader>ar",
        "y:CodyChat<CR>refactor following code:<CR><ESC>p<CR>",
        mode = "v",
        desc = "Request Refactoring",
      },
      {
        "<leader>ae",
        "y:CodyChat<CR>explain following code:<CR><ESC>p<CR>",
        mode = "v",
        desc = "Request Explanation",
      },
      {
        "<leader>at",
        "y:CodyChat<CR>rewrite following code more idiomatically:<CR><ESC>p<CR>",
        mode = "v",
        desc = "Request Idiomatic Rewrite",
      },
    },
  },
}
