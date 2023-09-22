--[[
-- Neovim Optionw
--]]

local vg = vim.g -- Global Options
local vo = vim.opt -- Set Options

--------------------
-- General
--------------------
vg.mapleader = " "
vg.maplocalleader = "\\"

--vo.clipboard = "unnamedplus" -- Sync clipboard between OS and Neovim.
vo.mouse = "a" -- Enable mouse mode
vo.ignorecase = true -- Case insensitive searching 
vo.smartcase = true -- UNLESS /C or capital in search
vo.splitright = true -- Open new window on the right
vo.splitbelow = true -- Open new window on the bottom
vo.termguicolors = true -- Enable terminal colors

--------------------
-- Neovim UI
--------------------
vo.cmdheight = 0 -- Merge statusline and command line
vo.laststatus = 2 -- Set statusline to always display
vo.cursorline = true -- Highlight current line in Insert mode
vo.hlsearch = false -- Highlight on search
vo.number = true -- Line numbers
vo.relativenumber = true -- Relative line numbers
vo.showmatch = true -- Highlight matching parenthesis

--------------------
-- Tabs & Indent
--------------------
vo.autoindent = true -- Enable autoindent
vo.breakindent = true -- Enable break indent
vo.expandtab = true -- Use spaces for tab
vo.shiftwidth = 2 -- Number of spaces for autoindent
vo.tabstop = 2 -- Number of spaces for tab

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
