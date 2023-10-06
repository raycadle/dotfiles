return {
  -- This module holds the statusline configuration
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
      lualine_b = {},
      lualine_c = {"filename"},
      lualine_x = {"diff"},
      lualine_y = {"branch"},
      lualine_z = {"location"},
    },
  },
}
