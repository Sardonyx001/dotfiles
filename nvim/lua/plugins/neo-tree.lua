return {
  "nvim-neo-tree/neo-tree.nvim",
  init = function()
    vim.api.nvim_create_autocmd("BufEnter", {
      -- make a group to be able to delete it later
      group = vim.api.nvim_create_augroup("NeoTreeInit", { clear = true }),
      callback = function()
        local f = vim.fn.expand("%:p")
        if vim.fn.isdirectory(f) ~= 0 then
          vim.cmd("Neotree current dir=" .. f)
          -- neo-tree is loaded now, delete the init autocmd
          vim.api.nvim_clear_autocmds({ group = "NeoTreeInit" })
        end
      end,
    })
    -- keymaps
  end,
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
    "MunifTanjim/nui.nvim",
    "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
  },
  opts = {
    window = {
      auto_expand_width = false,
      width = 25,
      mappings = {
        ["P"] = { "toggle_preview", config = { use_float = false, use_image_nvim = true } },
      },
    },
    filesystem = {
      hijack_netrw_behavior = "open_current",
      use_libuv_file_watcher = true,
      follow_current_file = { enabled = true },
      filtered_items = {
        visible = true,
        show_hidden_count = true,
        hide_dotfiles = false,
        hide_gitignored = false,
        hide_by_name = {
          ".git",
          ".DS_Store",
          "node_modules",
        },
        never_show = { ".DS_Store" },
      },
    },
  },
}
