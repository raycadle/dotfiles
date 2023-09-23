return {
  "nvim-lualine/lualine.nvim",
  opts = {
    options = {
      icons_enabled = false,
      theme = "catppuccin",
      disabled_filetypes = { statusline = { "alpha" } },
      component_separators = "|",
      section_separators = "",
    },
    sections = {
      lualine_a = {"mode"},
      lualine_b = {"branch"},
      lualine_c = {"filename"},
      lualine_x = {"diff"},
      lualine_y = {"location"},
      lualine_z = {
        function()
          return os.date("%R")
        end,
      },
    },
  },
}
