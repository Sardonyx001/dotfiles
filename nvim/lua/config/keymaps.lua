-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local map = vim.keymap.set

map("n", "<leader>gl", function()
  LazyVim.lazygit({ cwd = LazyVim.root.git() })
end, { desc = "Lazygit " })

map("n", "<leader>gL", function()
  LazyVim.lazygit({ args = { "log" } })
end, { desc = "Lazygit Log (cwd)" })

map("n", "<leader>L", "<cmd>Legendary<cr>", { desc = "Open Legendary" })

map({ "n", "v" }, "¥", "$", { desc = "End of line" })

map({ "n", "v" }, "^", "$", { desc = "End of line" })
