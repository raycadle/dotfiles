return {
  "nvim-telescope/telescope.nvim",
    lazy = true,
    dependencies = { "nvim-lua/plenary.nvim", lazy = true },
    cmd = "Telescope",
    keys = {
      { "<leader>,", "<cmd>Telescope buffers show_all_buffers=true<cr>", desc = "Switch Buffer" },
      { "<leader>/", "<cmd>Telescope live_grep<cr>", desc = "Live Grep" },
      { "<leader>:", "<cmd>Telescope command_history<cr>", desc = "Command History" },
      { "<leader><space>", "<cmd>Telescope find_files<cr>", desc = "Find Files" },
      -- find
      { "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Buffers" },
      { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find Files" },
      { "<leader>fr", "<cmd>Telescope oldfiles<cr>", desc = "Recent" },
      -- git
      { "<leader>gc", "<cmd>Telescope git_commits<cr>", desc = "Git Commits" },
      { "<leader>gs", "<cmd>Telescope git_status<cr>", desc = "Git Status" },
      { "<leader>gb", "<cmd>Telescope git_branches<cr>", desc = "Git Branches" },
      -- search
      { '<leader>s"', "<cmd>Telescope registers<cr>", desc = "Search Registers" },
      { "<leader>sa", "<cmd>Telescope autocommands<cr>", desc = "Search Auto Commands" },
      { "<leader>sb", "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "Search Buffer" },
      { "<leader>sc", "<cmd>Telescope command_history<cr>", desc = "Search Command History" },
      { "<leader>sC", "<cmd>Telescope commands<cr>", desc = "Search Commands" },
      { "<leader>sd", "<cmd>Telescope diagnostics bufnr=0<cr>", desc = "Search Document Diagnostics" },
      { "<leader>sD", "<cmd>Telescope diagnostics<cr>", desc = "Search Workspace Diagnostics" },
      { "<leader>sg", "<cmd>Telescope live_grep<cr>", desc = "Live Grep" },
      { "<leader>sh", "<cmd>Telescope help_tags<cr>", desc = "Search Help Pages" },
      { "<leader>sH", "<cmd>Telescope highlights<cr>", desc = "Search Highlight Groups" },
      { "<leader>sk", "<cmd>Telescope keymaps<cr>", desc = "Search Keymaps" },
      { "<leader>sM", "<cmd>Telescope man_pages<cr>", desc = "Search Man Pages" },
      { "<leader>sm", "<cmd>Telescope marks<cr>", desc = "Search Marks" },
      { "<leader>so", "<cmd>Telescope vim_options<cr>", desc = "Search Options" },
      { "<leader>sR", "<cmd>Telescope resume<cr>", desc = "Resume" },
      { "<leader>sw", "<cmd>Telescope grep_string<cr>", desc = "Grep String" },
      { "<leader>sw", "<cmd>Telescope grep_string<cr>", mode = "v", desc = "Grep Selection" },
      { "<leader>uC", "<cmd>Telescope colorscheme<cr>", desc = "Search Colorschemes" },
    },
}