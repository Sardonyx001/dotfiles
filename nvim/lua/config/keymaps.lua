-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local map = vim.keymap.set

-- Lazygit keybind
map("n", "<leader>gl", function()
  LazyVim.lazygit({ cwd = LazyVim.root.git() })
end, { desc = "Lazygit " })

-- Lazygit keybind
map("n", "<leader>gL", function()
  LazyVim.lazygit({ args = { "log" } })
end, { desc = "Lazygit Log (cwd)" })

-- Add Legendary keybind
map("n", "<leader>L", "<cmd>Legendary<cr>", { desc = "Open Legendary" })

-- JP keyboard jump to end of line
map({ "n", "v" }, "¥", "$", { desc = "End of line" })

-- US keyboard jump to end of line
map({ "n", "v" }, "-", "$", { desc = "End of line" })

-- Jump inside tag (like html tags)
map("n", "<leader>jt", "vit<Esc>`>", { desc = "Jump inside a tag", noremap = true, silent = true })

map("n", "<leader>c,", "<cmd>CsvViewToggle<cr>", { desc = "Enable table view" })

-- Map <leader>by to yank entire buffer to clipboard
map({ "n", "v" }, "<leader>by", "<cmd>%y+<cr>", { desc = "Yank entire file" })
