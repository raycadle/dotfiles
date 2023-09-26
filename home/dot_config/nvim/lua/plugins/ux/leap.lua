return {
  "ggandor/leap.nvim",
  event = "VeryLazy",
  lazy = true,
  config = function()
    require("leap").add_default_mappings()
  end,
}
