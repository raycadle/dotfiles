return {
  {
    "goolord/alpha-nvim",
    event = "VimEnter",
    opts = function()
      local dashboard = require("alpha.themes.dashboard")
      local logo = [[
███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗
████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║
██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║
██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║
██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║
╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝
      ]]

      dashboard.section.header.val = vim.split(logo, "\n")
      dashboard.section.buttons.val = {
        dashboard.button("n", " " .. " New file", ":ene <BAR> startinsert <CR>"),
        dashboard.button("r", " " .. " Recent files", ":Telescope oldfiles <CR>"),
        dashboard.button("f", " " .. " Find file", ":Telescope find_files <CR>"),
        dashboard.button("g", " " .. " Find text", ":Telescope live_grep <CR>"),
        dashboard.button("k", " " .. " Keys", ":WhichKey <CR>"),
        dashboard.button("l", "󰒲 " .. " Lazy", ":Lazy<CR>"),
        dashboard.button("c", " " .. " Config", ":e $MYVIMRC <CR>"),
        dashboard.button("q", " " .. " Quit", ":qa<CR>"),
      }
      for _, button in ipairs(dashboard.section.buttons.val) do
        button.opts.hl = "AlphaButtons"
        button.opts.hl_shortcut = "AlphaShortcut"
      end
      dashboard.section.header.opts.hl = "AlphaHeader"
      dashboard.section.buttons.opts.hl = "AlphaButtons"
      dashboard.section.footer.opts.hl = "AlphaFooter"
      dashboard.opts.layout[1].val = 8
      return dashboard
    end,
    config = function(_, dashboard)
      -- close Lazy and re-open when the dashboard is ready
      if vim.o.filetype == "lazy" then
        vim.cmd.close()
        vim.api.nvim_create_autocmd("User", {
          pattern = "AlphaReady",
          callback = function()
            require("lazy").show()
          end,
        })
      end

      require("alpha").setup(dashboard.opts)

      vim.api.nvim_create_autocmd("User", {
        pattern = "LazyVimStarted",
        callback = function()
          local stats = require("lazy").stats()
          local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
          dashboard.section.footer.val = "⚡ Neovim loaded " .. stats.count .. " plugins in " .. ms .. "ms"
          --[[
          local handle = io.popen('fortune')
          local fortune = handle:read("*a")
          handle:close()
          dashboard.section.footer.val = fortune
          --]]
          pcall(vim.cmd.AlphaRedraw)
        end,
      })
    end,
  },
  {
    "nvim-telescope/telescope.nvim",
    event = "VeryLazy",
    dependencies = {
      {
        "nvim-lua/plenary.nvim",
        event = "VeryLazy",
      },
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        event = "VeryLazy",
        build = "make",
        config = function()
          require("telescope").load_extension("fzf")
        end,
      },
    },
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
  },
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
    end,
    opts = {
      defaults = {
          mode = { "n", "v" },
          ["g"] = { name = "+goto" },
          ["gz"] = { name = "+surround" },
          ["]"] = { name = "+next" },
          ["["] = { name = "+prev" },
          ["<leader><tab>"] = { name = "+tabs" },
          ["<leader>b"] = { name = "+buffer" },
          ["<leader>f"] = { name = "+file/find" },
          ["<leader>g"] = { name = "+git" },
          ["<leader>q"] = { name = "+quit/session" },
          ["<leader>s"] = { name = "+search" },
          ["<leader>t"] = { name = "+terminal" },
          ["<leader>u"] = { name = "+ui" },
          ["<leader>w"] = { name = "+windows" },
          ["<leader>x"] = { name = "+diagnostics/quickfix" },
      },
    },
    config = function(_, opts)
        local wk = require("which-key")
        wk.setup(opts)
        wk.register(opts.defaults)
    end,
  },
  {
    "akinsho/bufferline.nvim",
    version = "*",
    dependencies = "nvim-tree/nvim-web-devicons",
    config = function()
      require("bufferline").setup{}
    end,
  },
  {
    "ggandor/leap.nvim",
    event = "VeryLazy",
    config = function()
      require("leap").add_default_mappings()
    end,
  },
  {
    "voldikss/vim-floaterm",
    event = "VeryLazy",
  },
}
