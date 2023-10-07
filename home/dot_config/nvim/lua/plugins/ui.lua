return {
  {
    -- This module holds the colorscheme configuration
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
      require("catppuccin").setup({
        flavour = "mocha",
        background = { -- :h background
          light = "latte",
          dark = "mocha",
        },
        transparent_background = false,
        show_end_of_buffer = false,
        term_colors = true,
        styles = {
          comments = {},
          conditionals = {},
        },
        color_overrides = {
          mocha = {
            base = "#000000",
          },
        },
        integrations = {
          alpha = true,
          leap = true,
          telescope = true,
          which_key = true,
          -- visit github.com/catppuccin/nvim#integrations
        },
      })
      -- setup must be called before loading
      vim.cmd.colorscheme "catppuccin"
    end,
  },
  {
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
  },
  {
    "ap/vim-css-color",
    event = "VeryLazy",
  },
}
