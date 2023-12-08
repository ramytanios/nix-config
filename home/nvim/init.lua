vim.g.mapleader = " " -- space leader keymap

local map = vim.keymap.set
local tree = require("nvim-tree.api")
local trouble = require("trouble")
local trtoggle = trouble.toggle
local cf = require("conform")
local gs = require("gitsigns")
local flash = require("flash")
local tb = require("telescope.builtin")
local tel = require("telescope")
local oil = require("oil")

map("i", "jk", "<ESC>", { desc = "Insert to Visual mode" })
map("i", "jj", "<ESC>", { desc = "Insert to Visual mode" })
map("i", "kj", "<ESC>", { desc = "Insert to Visual mode" })

map("v", "J", ":m '>+1<CR>gv=gv")
map("v", "K", ":m '<-2<CR>gv=gv")
map("n", "yw", "viwy", { desc = "Yank inner word" })
map("n", "pw", "viwP", { desc = "Paste yanked word in place of current inner word, multiple times (P)" })

map("n", "<leader>noh", ":nohl<CR>", { desc = "Clear highlight" })
map("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" })
map("n", "<leader>ss", "<C-w>s", { desc = "Split window horizontal" })
map("n", "<leader>se", "<C-w>=", { desc = "Make split equal width" })
map("n", "<leader>sx", ":close<CR>", { desc = "Close current split" })
map("n", "<leader>cf", "<cmd>edit $MYVIMRC<CR>", { desc = "open init.lua" })

map("n", "<leader>tr", tree.tree.toggle, { desc = "Toggle nvim tree" })

map("n", "<leader>tt", trtoggle, { desc = "Toggle trouble" })

map("n", "<leader>tw", function()
	trtoggle("workspace_diagnostics")
end, { desc = "Trouble work diagnostics" })

map("n", "<leader>td", function()
	trtoggle("document_diagnostics")
end, { desc = "Trouble document diagnostics" })

map("n", "<leader>tl", function()
	trtoggle("loclist")
end, { desc = "Trouble loclist" })

map("n", "<leader>tq", function()
	trtoggle("quickfix")
end, { desc = "Trouble quickfix" })

map("n", "<leader>d", function()
	trtoggle("lsp_definitions")
end, { desc = "Trouble lsp definitions" })

map("n", "<leader>r", function()
	trtoggle("lsp_references")
end, { desc = "Trouble lsp references" })

map("n", "<leader>tn", function()
	trouble.next({ skip_groups = true, jump = true })
end, { desc = "Trouble next" })

map("n", "<leader>tp", function()
	trouble.previous({ skip_groups = true, jump = true })
end, { desc = "Trouble previous" })

map("n", "<leader>h", vim.lsp.buf.hover, { desc = "Lsp hover" })

map("n", "<leader>i", vim.lsp.buf.implementation, { desc = "Lsp implementation" })

map("n", "<leader>s", vim.lsp.buf.document_symbol, { desc = "Lsp document symbol" })

map("n", "<leader>ws", vim.lsp.buf.workspace_symbol, { desc = "Lsp workspace symbol" })

map("n", "<leader>sh", vim.lsp.buf.signature_help, { desc = "Lsp signature help" })

map("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Lsp rename" })

map("n", "<leader>f", function()
	cf.format({ lsp_fallback = true, async = false, timeout_ms = 3000 })
end, { desc = "Conform / LSP format" })

map("n", "<leader>a", vim.lsp.buf.code_action, { desc = "Lsp code action" })

map("n", "<leader>nh", gs.next_hunk, { desc = "Gitsigns next hunk" })

map("n", "<leader>ph", gs.preview_hunk, { desc = "Gitsigns preview hunk" })

map("n", "<leader>prh", gs.prev_hunk, { desc = "Gitsigns previous hunk" })

map("n", "<leader>rh", gs.reset_hunk, { desc = "Gitsigns reset hunk" })

map("n", "<leader>gh", gs.select_hunk, { desc = "Gitsigns select hunk" })

map("n", "<leader>lb", gs.toggle_current_line_blame, { desc = "Gitsigns toggle current blame" })

map({ "n", "x", "o" }, "s", flash.jump, { desc = "Flash jump" })

map({ "n", "x", "o" }, "S", flash.treesitter, { desc = "Flash treesitter search" })

map("n", "<leader>?", tb.oldfiles, { desc = "Telescope old files" })

map("n", "<leader>ff", tb.find_files, { desc = "Telescope find files" })

map("n", "<leader>lg", tb.live_grep, { desc = "Telescope live grep" })

map("n", "<leader>gr", tb.grep_string, { desc = "Telescope grep string" })

map("n", "<leader>fb", tb.buffers, { desc = "Telescope buffers" })

map("n", "<leader>ht", tb.help_tags, { desc = "Telescope help tags" })

map("n", "<leader>fda", tb.diagnostics, { desc = "Telescope diagnostics" })

map("n", "<leader>gc", tb.git_commits, { desc = "Telescope git commits" })

map("n", "<leader>gb", tb.git_branches, { desc = "Telescope git branches" })

map("n", "<leader>gs", tb.git_status, { desc = "Telescope git status" })

map("n", "<leader>co", tb.commands, { desc = "Telescope commands" })

map("n", "<leader>gf", tb.git_files, { desc = "Telescope git files" })

map("n", "<leader>mc", tel.extensions.metals.commands, { desc = "Metals commands" })

map("n", "<leader>cs", function()
	tb.colorscheme({ enable_preview = true })
end, { desc = "Select colorscheme" })

map("n", "<leader>fd", vim.diagnostic.open_float, { desc = "Diagnostic open float" })

map("n", "-", oil.open, { desc = "Browse parent directory" })

--TODO: use lua
map("n", "<leader>dv", ":DiffviewOpen<SPACE>", { noremap = true, desc = "" })
map("n", "<leader>dvx", ":DiffviewClose<CR>", { noremap = true, desc = "" })

local opt = vim.opt
opt.relativenumber = true
opt.number = true
opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.autoindent = true
opt.wrap = false
opt.ignorecase = true
opt.smartcase = true
opt.cursorline = true
opt.termguicolors = true
opt.background = "dark"
opt.signcolumn = "yes"
opt.backspace = "indent,eol,start"
opt.clipboard:append("unnamedplus")
opt.splitright = true 
opt.splitbelow = true
opt.swapfile = false

vim.cmd("colorscheme tokyonight-storm")
