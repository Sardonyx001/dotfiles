return {
  -- change some telescope options and a keymap to browse plugin files
  "nvim-telescope/telescope.nvim",
  dependencies = {
    "nvim-telescope/telescope-fzf-native.nvim",
    build = "make",
    config = function()
      require("telescope").load_extension("fzf")
    end,
  },
  lazy = false,
  keys = {
    {
      "<leader>fp",
      function()
        require("telescope.builtin").find_files({ cwd = "~/.config/nvim" })
      end,
      desc = "Find Plugin File",
    },
  },
  opts = {
    defaults = {
      mappings = {
        i = {
          ["<esc>"] = require("telescope.actions").close,
          ["<C-h>"] = "which_key",
        },
      },
      path_display = { "smart" },
      layout_strategy = "horizontal",
      layout_config = { prompt_position = "top" },
      sorting_strategy = "ascending",
      winblend = 10,
    },
  },
  extensions = {
    fzf = {
      fuzzy = true, -- false will only do exact matching
      override_generic_sorter = true, -- override the generic sorter
      override_file_sorter = true, -- override the file sorter
      case_mode = "smart_case", -- or "ignore_case" or "respect_case"
    },
  },
}
