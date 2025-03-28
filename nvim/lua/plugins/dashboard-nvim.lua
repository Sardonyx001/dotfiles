local logo = [[
                   ▄ ▄                           
               ▄   ▄▄▄     ▄ ▄▄▄ ▄ ▄             
               █ ▄ █▄█ ▄▄▄ █ █▄█ █ █             
            ▄▄ █▄█▄▄▄█ █▄█▄█▄▄█▄▄█ █             
          ▄ █▄▄█ ▄ ▄▄ ▄█ ▄▄▄▄▄▄▄▄▄▄▄▄▄▄          
          █▄▄▄▄ ▄▄▄ █ ▄ ▄▄▄ ▄ ▄▄▄ ▄ ▄ █ ▄        
        ▄ █ █▄█ █▄█ █ █ █▄█ █ █▄█ ▄▄▄ █ █        
        █▄█ ▄ █▄▄█▄▄█ █ ▄▄█ █ ▄ █ █▄█▄█ █        
            █▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄█ █▄█▄▄▄█            
]]
logo = string.rep("\n", 8) .. logo .. "\n\n"

return {
  "nvimdev/dashboard-nvim",
  event = "VimEnter",
  opts = {
    theme = "hyper",
    config = {
      packages = { enable = true }, -- show how many plugins neovim loaded
      header = vim.split(logo, "\n"),
      -- no weekly header instead use the above header
      -- week_header = {
      --   enable = false,
      -- },
      shortcut = {
        {
          desc = "󰊳 update",
          group = "@property",
          action = "Lazy update",
          key = "u",
        },
        {
          icon = " ",
          icon_hl = "@variable",
          desc = "files",
          group = "Label",
          action = "Telescope find_files",
          key = "f",
        },
        {
          desc = "  home",
          group = "DiagnosticHint",
          action = "cd ~/Projects | Neotree",
          key = "h",
        },
        {
          desc = "🚧 wip",
          group = "DiagnosticHint",
          action = "cd ~/Projects/wip | Neotree",
          key = "w",
        },
        {
          desc = " dotfiles",
          group = "Number",
          action = "lua LazyVim.pick.config_files()()",
          key = "d",
        },
        {
          desc = " extras",
          group = "Label",
          action = "LazyExtras",
          key = "x",
        },
      },
      footer = {},
    },
  },
}
