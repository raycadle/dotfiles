return {
  { -- Set lualine as statusline
    "nvim-lualine/lualine.nvim",
    opts = {
      options = {
        icons_enabled = false,
        theme = "catppuccin",
        component_separators = "|",
        section_separators = "",
      },
      sections = {
        lualine_a = {"mode"},
        lualine_b = {
          {
            "filename",
            file_status = true,
          }
        },
        lualine_c = {},
        lualine_x = {},
        lualine_y = {},
        lualine_z = {
          {
            "location",
            --enable_last = true,
          }
        },
      },
    },
  },
}
