-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here
--

-- Disable spellchecking for markdown and text files
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "markdown", "text" },
  callback = function()
    vim.opt_local.spell = false
  end,
})

vim.api.nvim_create_autocmd({ "FileType" }, {
  group = vim.api.nvim_create_augroup("csvview_loading", {}),
  desc = "Add key shortcuts for csv files",
  pattern = { "csv", "tsv" },
  callback = function(ev)
    local function setup_csvview_keys(buf)
      vim.keymap.set("n", "<leader>c,", require("csvview").toggle, { buffer = buf, desc = "Enable table view" })
    end
    setup_csvview_keys(ev.buf)
    require("csvview").enable()
  end,
})
