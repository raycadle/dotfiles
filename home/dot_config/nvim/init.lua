--[[
    
███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗
████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║
██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║
██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║
██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║
╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝
    
--]]

--[[
============================================================================

    GENERAL CONFIGURATION

============================================================================
--]]

-- Basic Settings
vim.opt.number = true -- Line numbers
vim.opt.relativenumber = true -- Relative line numbers
vim.opt.cursorline = true -- Highlight current line
vim.opt.wrap = false -- Don't wrap lines
vim.opt.scrolloff = 10 -- Keep 10 lines above/below cursor 
vim.opt.sidescrolloff = 8 -- Keep 8 columns left/right of cursor

-- Indentation
vim.opt.tabstop = 2 -- Tab width
vim.opt.shiftwidth = 2 -- Indent width
vim.opt.softtabstop = 2 -- Soft tab stop
vim.opt.expandtab = true -- Use spaces instead of tabs
vim.opt.smartindent = true -- Smart auto-indenting
vim.opt.autoindent = true -- Copy indent from current line
vim.opt.breakindent = true -- Enable break indent

-- Search Settings
vim.opt.ignorecase = true -- Case insensitive search
vim.opt.smartcase = true -- Case sensitive if uppercase in search
vim.opt.hlsearch = false -- Don't highlight search results 
vim.opt.incsearch = true -- Show matches as you type

-- Visual Settings
vim.opt.termguicolors = true -- Enable 24-bit colors
vim.opt.showmatch = true -- Highlight matching brackets
vim.opt.matchtime = 2 -- How long to show matching bracket
vim.opt.cmdheight = 0 -- Command line height
vim.opt.showcmdloc = "statusline"
vim.opt.laststatus = 3 -- Set statusline to always display
vim.opt.completeopt = "menuone,noinsert,noselect" -- Completion options 
vim.opt.showmode = false -- Don't show mode in command line 
vim.opt.pumheight = 10 -- Popup menu height 
vim.opt.pumblend = 10 -- Popup menu transparency 
vim.opt.winblend = 0 -- Floating window transparency 
vim.opt.conceallevel = 0 -- Don't hide markup 
vim.opt.concealcursor = "" -- Don't hide cursor line markup 
vim.opt.lazyredraw = true -- Don't redraw during macros
vim.opt.synmaxcol = 300 -- Syntax highlighting limit 

-- File Handling
vim.opt.backup = false -- Don't create backup files
vim.opt.writebackup = false -- Don't create backup before writing
vim.opt.swapfile = false -- Don't create swap files
vim.opt.updatetime = 300 -- Faster completion
vim.opt.timeoutlen = 1000 -- Key timeout duration
vim.opt.ttimeoutlen = 0 -- Key code timeout
vim.opt.autoread = true -- Auto reload files changed outside vim
vim.opt.autowrite = false -- Don't auto save

-- Behavior Settings
vim.opt.hidden = true -- Allow hidden buffers
vim.opt.errorbells = false -- No error bells
vim.opt.backspace = "indent,eol,start" -- Better backspace behavior
vim.opt.autochdir = false -- Don't auto change directory
vim.opt.iskeyword:append("-") -- Treat dash as part of word
vim.opt.path:append("**") -- include subdirectories in search
vim.opt.selection = "exclusive" -- Selection behavior
vim.opt.mouse = "a" -- Enable mouse support
--vim.opt.clipboard = "unnamedplus" -- Use system clipboard
vim.opt.modifiable = true -- Allow buffer modifications
vim.opt.encoding = "UTF-8" -- Set encoding

-- Split Behavior
vim.opt.splitbelow = true -- Horizontal splits go below
vim.opt.splitright = true -- Vertical splits go right

vim.opt.confirm = true -- Prompt to save before quitting

-- Command-line completion
vim.opt.wildmenu = true
vim.opt.wildmode = "longest:full,full"
vim.opt.wildignore:append({ "*.o", "*.obj", "*.pyc", "*.class", "*.jar" })

-- Better diff options
vim.opt.diffopt:append("linematch:60")

-- Performance improvements
vim.opt.redrawtime = 10000
vim.opt.maxmempattern = 20000

-- Provider Settings
vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0

--[[
============================================================================

    FLOATING TERMINAL

============================================================================
--]]

-- Terminal
local terminal_state = {
  buf = nil,
  win = nil,
  is_open = false
}

local function FloatingTerminal()
  -- If terminal is already open, close it (toggle behavior)
  if terminal_state.is_open and vim.api.nvim_win_is_valid(terminal_state.win) then
    vim.api.nvim_win_close(terminal_state.win, false)
    terminal_state.is_open = false
    return
  end

  -- Create buffer if it doesn't exist or is invalid
  if not terminal_state.buf or not vim.api.nvim_buf_is_valid(terminal_state.buf) then
    terminal_state.buf = vim.api.nvim_create_buf(false, true)
    -- Set buffer options for better terminal experience
    vim.api.nvim_buf_set_option(terminal_state.buf, 'bufhidden', 'hide')
  end

  -- Calculate window dimensions
  local width = math.floor(vim.o.columns * 0.8)
  local height = math.floor(vim.o.lines * 0.8)
  local row = math.floor((vim.o.lines - height) / 2)
  local col = math.floor((vim.o.columns - width) / 2)

  -- Create the floating window
  terminal_state.win = vim.api.nvim_open_win(terminal_state.buf, true, {
    relative = 'editor',
    width = width,
    height = height,
    row = row,
    col = col,
    style = 'minimal',
    border = 'rounded',
  })

  -- Set transparency for the floating window
  vim.api.nvim_win_set_option(terminal_state.win, 'winblend', 0)

  -- Set transparent background for the window
  vim.api.nvim_win_set_option(terminal_state.win, 'winhighlight',
    'Normal:FloatingTermNormal,FloatBorder:FloatingTermBorder')

  -- Define highlight groups for transparency
  vim.api.nvim_set_hl(0, "FloatingTermNormal", { bg = "none" })
  vim.api.nvim_set_hl(0, "FloatingTermBorder", { bg = "none", })

  -- Start terminal if not already running
  local has_terminal = false
  local lines = vim.api.nvim_buf_get_lines(terminal_state.buf, 0, -1, false)
  for _, line in ipairs(lines) do
    if line ~= "" then
      has_terminal = true
      break
    end
  end

  if not has_terminal then
    vim.fn.termopen(os.getenv("SHELL"))
  end

  terminal_state.is_open = true
  vim.cmd("startinsert")

  -- Set up auto-close on buffer leave 
  vim.api.nvim_create_autocmd("BufLeave", {
    buffer = terminal_state.buf,
    callback = function()
      if terminal_state.is_open and vim.api.nvim_win_is_valid(terminal_state.win) then
        vim.api.nvim_win_close(terminal_state.win, false)
        terminal_state.is_open = false
      end
    end,
    once = true
  })
end

-- Function to explicitly close the terminal
local function CloseFloatingTerminal()
  if terminal_state.is_open and vim.api.nvim_win_is_valid(terminal_state.win) then
    vim.api.nvim_win_close(terminal_state.win, false)
    terminal_state.is_open = false
  end
end

--[[
============================================================================

    TABS

============================================================================
--]]

-- Tab display settings
vim.opt.showtabline = 1  -- Always show tabline (0=never, 1=when multiple tabs, 2=always)
vim.opt.tabline = ''     -- Use default tabline (empty string uses built-in)

-- Transparent tabline appearance
vim.cmd([[
  hi TabLineFill guibg=NONE ctermfg=242 ctermbg=NONE
]])

-- Function to open file in new tab
local function open_file_in_tab()
  vim.ui.input({ prompt = 'File to open in new tab: ', completion = 'file' }, function(input)
    if input and input ~= '' then
      vim.cmd('tabnew ' .. input)
    end
  end)
end

-- Function to duplicate current tab
local function duplicate_tab()
  local current_file = vim.fn.expand('%:p')
  if current_file ~= '' then
    vim.cmd('tabnew ' .. current_file)
  else
    vim.cmd('tabnew')
  end
end

-- Function to close tabs to the right
local function close_tabs_right()
  local current_tab = vim.fn.tabpagenr()
  local last_tab = vim.fn.tabpagenr('$')

  for i = last_tab, current_tab + 1, -1 do
    vim.cmd(i .. 'tabclose')
  end
end

-- Function to close tabs to the left
local function close_tabs_left()
  local current_tab = vim.fn.tabpagenr()

  for i = current_tab - 1, 1, -1 do
    vim.cmd('1tabclose')
  end
end

-- Function to close buffer but keep tab if it's the only buffer in tab
local function smart_close_buffer()
  local buffers_in_tab = #vim.fn.tabpagebuflist()
  if buffers_in_tab > 1 then
    vim.cmd('bdelete')
  else
    -- If it's the only buffer in tab, close the tab
    vim.cmd('tabclose')
  end
end

--[[
============================================================================

    STATUSLINE

============================================================================
--]]

-- Mode Indicator
local function mode_icon()
  local current_mode = vim.fn.mode()
  local modes = {
    n = "NORMAL",
    i = "INSERT",
    v = "VISUAL",
    V = "V-LINE",
    ["\22"] = "V-BLOCK",
    c = "COMMAND",
    s = "SELECT",
    S = "S-LINE",
    ["\19"] = "S-BLOCK",
    r = "REPLACE",
    R = "REPLACE",
    ["!"] = "SHELL",
    t = "TERMINAL"
  }
  return modes[current_mode] or "  " .. current_mode:upper()
end

-- Define highlight groups for each mode
vim.cmd([[
    highlight StatusLineBold gui=bold cterm=bold
    highlight StatusLineAccent guibg=#89b4fa ctermbg=blue
    highlight StatusLineInsertAccent guibg=#a6e3a1 ctermbg=green
    highlight StatusLineVisualAccent guibg=#cba6f7 ctermbg=135
    highlight StatusLineReplaceAccent guibg=#f38ba8 ctermbg=red
    highlight StatusLineCmdLineAccent guibg=#fab387 ctermbg=242
    highlight StatusLineTerminalAccent guibg=#a6e3a1 ctermbg=green
]])

local function mode_color()
  local current_mode = vim.fn.mode()
  local mode_color = "%#StatusLineAccent#"  -- Default color
  
  if current_mode == "n" then
      mode_color = "%#StatusLineAccent#"
  elseif current_mode == "i" or current_mode == "ic" then
      mode_color = "%#StatusLineInsertAccent#"
  elseif current_mode == "v" or current_mode == "V" or current_mode == "\22" then
      mode_color = "%#StatusLineVisualAccent#"
  elseif current_mode == "r" or current_mode == "R" then
      mode_color = "%#StatusLineReplaceAccent#"
  elseif current_mode == "c" then
      mode_color = "%#StatusLineCmdLineAccent#"
  elseif current_mode == "t" then
      mode_color = "%#StatusLineTerminalAccent#"
  end
  
  return mode_color
end

-- Function to change statusline based on window focus
local function setup_dynamic_statusline()
  vim.api.nvim_create_autocmd({"WinEnter", "BufEnter", "ModeChanged"}, {
    callback = function()
    vim.opt_local.statusline = table.concat {
      "%#StatusLineBold#",
      mode_color(),
      " ",
      mode_icon(),
      " ",
      "%#StatusLine#",
      " %t %m%r",
      "%=",
      mode_color(),
      " %l/%L:%c ",
    }
    end
  })
  vim.api.nvim_set_hl(0, "StatusLineBold", { bold = true })

  vim.api.nvim_create_autocmd({"WinLeave", "BufLeave"}, {
    callback = function()
      vim.opt_local.statusline = " %t %m%r %= %l/%L:%c "
    end
  })
end

setup_dynamic_statusline()

--[[
============================================================================

    USEFUL FUNCTIONS

============================================================================
--]]

-- Basic autocommands
local augroup = vim.api.nvim_create_augroup("UserConfig", {})

-- Highlight yanked text
vim.api.nvim_create_autocmd("TextYankPost", {
  group = augroup,
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- Auto-close terminal when process exits
vim.api.nvim_create_autocmd("TermClose", {
  group = augroup,
  callback = function()
    if vim.v.event.status == 0 then
      vim.api.nvim_buf_delete(0, {})
    end
  end,
})

-- Disable line numbers in terminal
vim.api.nvim_create_autocmd("TermOpen", {
  group = augroup,
  callback = function()
    vim.opt_local.number = false
    vim.opt_local.relativenumber = false
    vim.opt_local.signcolumn = "no"
  end,
})

-- Auto-resize splits when window is resized
vim.api.nvim_create_autocmd("VimResized", {
  group = augroup,
  callback = function()
    vim.cmd("tabdo wincmd =")
  end,
})

-- Create directories when saving files
vim.api.nvim_create_autocmd("BufWritePre", {
  group = augroup,
  callback = function()
    local dir = vim.fn.expand('<afile>:p:h')
    if vim.fn.isdirectory(dir) == 0 then
      vim.fn.mkdir(dir, 'p')
    end
  end,
})

--[[
============================================================================

    KEYMAPS

============================================================================
--]]

vim.g.mapleader = " " -- Set leader key to space
vim.g.maplocalleader = " " -- Set local leader key (NEW)

local function map(mode, lhs, rhs, opts)
    vim.keymap.set(mode, lhs, rhs, opts)
end

-- Quick Config Editing
map("n", "<leader>rc", "<cmd>e ~/.config/nvim/init.lua<CR>", { desc = "Edit config" })

-- Quit
map("n", "<leader>qq", "<cmd>qa<cr>", { desc = "Quit all" })

-- Save File
map({ "i", "x", "n", "s" }, "<C-s>", "<cmd>w<cr><esc>", { desc = "Save file" })

-- New File
map("n", "<leader>fn", "<cmd>enew<cr>", { desc = "New file" })

-- Quick File Navigation
map("n", "<leader>e", "<cmd>Explore<CR>", { desc = "Open file explorer" })
map("n", "<leader>ff", "<cmd>find ", { desc = "Find file" })

-- Clear Search With <esc>
map({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>", { desc = "Escape and clear hlsearch" })

-- Better Up/Down
map({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
map({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })

-- Better Indenting
map("v", "<", "<gv", { desc = "Indent left and reselect" })
map("v", ">", ">gv", { desc = "Indent right and reselect" })

-- Terminal Mappings
map("n", "<leader>t", FloatingTerminal, { noremap = true, silent = true, desc = "Open floating terminal" })
map("t", "<Esc><Esc>", function()
  if terminal_state.is_open then
    vim.api.nvim_win_close(terminal_state.win, false)
    terminal_state.is_open = false
  end
end, { noremap = true, silent = true, desc = "Close floating terminal from terminal mode" })

-- Windows
map("n", "<leader>ww", "<C-w>p", { desc = "Other window", remap = true })
map("n", "<leader>wd", "<C-w>c", { desc = "Delete window", remap = true })
map("n", "<leader>wh", "<C-w>s", { desc = "Split window horizontally", remap = true })
map("n", "<leader>wv", "<C-w>v", { desc = "Split window vertically", remap = true })

-- Move to Window Using the <ctrl> hjkl Keys
map("n", "<C-h>", "<C-w>h", { desc = "Go to left window", remap = true })
map("n", "<C-j>", "<C-w>j", { desc = "Go to lower window", remap = true })
map("n", "<C-k>", "<C-w>k", { desc = "Go to upper window", remap = true })
map("n", "<C-l>", "<C-w>l", { desc = "Go to right window", remap = true })

-- Resize Window Using <ctrl> Arrow Keys
map("n", "<C-UP>", "<cmd>resize +2<cr>", { desc = "Increase window height" })
map("n", "<C-DOWN>", "<cmd>resize -2<cr>", { desc = "Decrease window height" })
map("n", "<C-LEFT>", "<cmd>vertical resize -2<cr>", { desc = "Decrease window width" })
map("n", "<C-RIGHT>", "<cmd>vertical resize +2<cr>", { desc = "Increase window width" })

-- Move Lines
map("n", "<A-j>", "<cmd>m .+1<cr>==", { desc = "Move down" })
map("n", "<A-k>", "<cmd>m .-2<cr>==", { desc = "Move up" })
map("i", "<A-j>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move down" })
map("i", "<A-k>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move up" })
map("v", "<A-j>", "<cmd>m '>+1<cr>gv=gv", { desc = "Move down" })
map("v", "<A-k>", "<cmd>m '<-2<cr>gv=gv", { desc = "Move up" })

-- Buffers
map("n", "<leader>bn", "<cmd>bnext<cr>", { desc = "Next buffer" })
map("n", "<leader>bp", "<cmd>bprevious<cr>", { desc = "Prev buffer" })
map("n", "<leader>bb", "<cmd>e #<cr>", { desc = "Switch to Other Buffer" })
map('n', '<leader>bd', smart_close_buffer, { desc = 'Smart close buffer/tab' })

-- Tabs
map("n", "<leader><tab>f", "<cmd>tabfirst<cr>", { desc = "First Tab" })
map("n", "<leader><tab>l", "<cmd>tablast<cr>", { desc = "Last Tab" })
map("n", "<leader><tab><tab>", "<cmd>tabnew<cr>", { desc = "New Tab" })
map("n", "<leader><tab>d", "<cmd>tabclose<cr>", { desc = "Close Tab" })
map("n", "<leader><tab>n", "<cmd>tabnext<cr>", { desc = "Next Tab" })
map("n", "<leader><tab>p", "<cmd>tabprevious<cr>", { desc = "Previous Tab" })
map('n', '<leader><tab>>', '<cmd>tabmove +1<CR>', { desc = 'Move Tab Right' })
map('n', '<leader><tab><', '<cmd>tabmove -1<CR>', { desc = 'Move tab left' })
map('n', '<leader><tab>O', open_file_in_tab, { desc = 'Open file in new tab' })
map('n', '<leader><tab>D', duplicate_tab, { desc = 'Duplicate current tab' })
map('n', '<leader><tab>R', close_tabs_right, { desc = 'Close tabs to the right' })
map('n', '<leader><tab>L', close_tabs_left, { desc = 'Close tabs to the left' })

-- Center Screen When Jumping
map("n", "n", "nzzzv", { desc = "Next search result (centered)" })
map("n", "N", "Nzzzv", { desc = "Previous search result (centered)" })
map("n", "<C-d>", "<C-d>zz", { desc = "Half page down (centered)" })
map("n", "<C-u>", "<C-u>zz", { desc = "Half page up (centered)" })