-- gitlinker.nvim
-- This module sets up Gitlinker to generate links to code in a specific Git repository.
-- It customizes the URL format for a specific Git host (git.rakuten-it.com) to match the desired structure.

return {
  "ruifm/gitlinker.nvim",
  event = "VeryLazy",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope.nvim",
  },
  config = function()
    require("gitlinker").setup({
      mappings = "<leader>gy",
      callbacks = {
        ["git.rakuten-it.com"] = function(url_data)
          -- url_data.repo is "<user>/<repo>"
          -- for my usecase, I need "projects/<project>/repos/<repo>"
          local user, repo = url_data.repo:match("([^/]+)/(.+)")
          if not user or not repo then
            return nil -- fallback if repo format is unexpected
          end
          local url = "https://"
            .. url_data.host
            .. "/projects/"
            .. user
            .. "/repos/"
            .. repo
            .. "/browse/"
            .. url_data.file
            .. "?at="
            .. url_data.rev
          -- Add line or line range anchor if present
          if url_data.lstart then
            url = url .. "#" .. tostring(url_data.lstart)
            if url_data.lend and url_data.lend ~= url_data.lstart then
              url = url .. "-" .. tostring(url_data.lend)
            end
          end
          return url
        end,
      },
      opts = {},
    })
  end,
}
