return {
  "stevearc/conform.nvim",
  opts = {
    formatters_by_ft = {
      xml = { "xml" },
    },
    formatters = {
      xml = {
        command = "xmlformat",
      },
    },
  },
}
