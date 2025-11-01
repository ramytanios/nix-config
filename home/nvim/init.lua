---@diagnostic disable: missing-fields

vim.g.mapleader = " "

local opt = vim.opt
opt.relativenumber = true
opt.number = true
opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.autoindent = true
opt.smartindent = true
opt.wrap = false
opt.ignorecase = true
opt.smartcase = true
opt.cursorline = true
opt.termguicolors = true
opt.signcolumn = "yes"
opt.backspace = "indent,eol,start"
opt.clipboard:append("unnamedplus")
opt.splitright = true
opt.splitbelow = true
opt.swapfile = false

local map = vim.keymap.set

local conform = require("conform")

local gitsigns = require("gitsigns")

local todo = require("todo-comments")

local flash = require("flash")

local oil = require("oil")

local trouble = require("trouble")

local metals = require("metals")

map("i", "jk", "<ESC>", { desc = "insert to visual mode" })

map("i", "jj", "<ESC>", { desc = "insert to visual mode" })

map("i", "kj", "<ESC>", { desc = "insert to visual mode" })

map("v", "J", ":m '>+1<CR>gv=gv")

map("v", "K", ":m '<-2<CR>gv=gv")

map("n", "<leader>qq", ":q<CR>", { desc = ":q" })

map("n", "<leader>sv", "<C-w>v", { desc = "split window vertically" })

map("n", "<leader>ss", "<C-w>s", { desc = "split window horizontal" })

map("n", "<leader>se", "<C-w>=", { desc = "make split equal width" })

map("n", "<leader>+", "<C-a>", { desc = "increment number" })

map("n", "<leader>-", "<C-x>", { desc = "decrement number" })

map("n", "<leader>sx", ":close<CR>", { desc = "close current split" })

map("n", "<leader>cf", "<cmd>edit $MYVIMRC<CR>", { desc = "open init.lua" })

map("n", "-", oil.open, { desc = "browse parent directory" })

map("n", "<leader>tw", "<cmd>Trouble diagnostics toggle<cr>", { desc = "workspace diagnostics" })

map("n", "<leader>td", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", { desc = "document diagnostics" })

map("n", "<leader>d", function()
	trouble.toggle("lsp_definitions")
end, { desc = "lsp definitions" })

map("n", "<leader>rf", function()
	trouble.toggle("lsp_references")
end, { desc = "lsp references" })

map("n", "<leader>h", vim.lsp.buf.hover, { desc = "lsp hover" })

map("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "lsp code action" })

map("n", "<leader>rn", vim.lsp.buf.rename, { desc = "lsp rename" })

map("n", "<leader>fd", vim.diagnostic.open_float, { desc = "diagnostic open float" })

map("n", "<leader>fo", function()
	conform.format({ lsp_fallback = true, async = false, timeout_ms = 3000 })
end, { desc = "Conform / LSP format" })

map("n", "]t", todo.jump_next, { desc = "next todo comment" })

map("n", "[t", todo.jump_prev, { desc = "previous todo comment" })

map("n", "]h", gitsigns.next_hunk, { desc = "gitsigns next hunk" })

map("n", "[h", gitsigns.prev_hunk, { desc = "gitsigns previous hunk" })

map("n", "<leader>ph", gitsigns.preview_hunk, { desc = "gitsigns preview hunk" })

map("n", "<leader>rh", gitsigns.reset_hunk, { desc = "gitsigns reset hunk" })

map("n", "<leader>rb", gitsigns.reset_buffer, { desc = "gitsigns reset buffer" })

map("n", "<leader>sh", gitsigns.select_hunk, { desc = "gitsigns select hunk" })

map("n", "<leader>gd", ":DiffviewOpen<CR>", { noremap = true, desc = "open git diff view" })

map("n", "<leader>bd", ":DiffviewOpen<SPACE>", { noremap = true, desc = "branch diff view" })
-- map("n", "<leader>bd", function()
-- 	vim.ui.input({ prompt = "Enter branch name" }, function(branch)
-- 		local command = ":DiffviewOpen " .. branch
-- 		vim.cmd(command)
-- 	end)
-- end, { noremap = true, desc = "branch diff view" })

map("n", "<leader>bl",  function() Snacks.git.blame_line() end, { desc = "toggle git blame line" })

map("n", "<leader>gh", ":DiffviewFileHistory<CR>", { noremap = true, desc = "open git project history" })

map("n", "<leader>fh", ":DiffviewFileHistory %<CR>", { noremap = true, desc = "open git current file history" })

map("n", "<leader>gx", ":DiffviewClose<CR>", { noremap = true, desc = "close diff view" })

map({ "n", "x", "o" }, "s", flash.jump, { desc = "flash jump" })

map({ "n", "x", "o" }, "S", flash.treesitter, { desc = "flash treesitter search" })

map({ "o", "x" }, "R", flash.treesitter_search, { desc = "treesitter search" })

map("n", "<leader>fe", function() Snacks.picker.explorer() end, { desc = "file explorer" })

map("n", "<leader>ff", function() Snacks.picker.files() end, { desc = "find files" })

map("n", "<leader>lg", function() Snacks.picker.grep() end, { desc = "live grep" })

map("n", "<leader>gs", function() Snacks.picker.grep_word() end, { desc = "grep word or selection" })

map("n", "<leader>co", function() Snacks.picker.commands() end, { desc = "commands" })

map("n", "<leader>cs", function() Snacks.picker.colorschemes() end, { desc = "colorschemes" })

map("n", "<leader>ls", function() Snacks.picker.lsp_workspace_symbols() end, { desc = "live workspace symbols" })

map({ "n", "t" }, "]]", function() Snacks.words.jump(vim.v.count1) end, { desc = "Next Reference"})

map({ "n", "t" }, "[[", function() Snacks.words.jump(-vim.v.count1) end, { desc = "Prev Reference"})

map("n", "<leader>sj", function() Snacks.picker.jumps() end, { desc = "Jumps" })

map("n", "<leader>lz", function() Snacks.lazygit.open() end, { desc = "Lazygit" })

map("n",  "<leader>gi", function() Snacks.picker.gh_issue() end, { desc = "GitHub Issues (open)" })

map("n",  "<leader>gI", function() Snacks.picker.gh_issue({ state = "all" }) end, { desc = "GitHub Issues (all)"})

map("n",  "<leader>gp", function() Snacks.picker.gh_pr() end, {desc = "GitHub Pull Requests (open)"})

map("n",  "<leader>gP", function() Snacks.picker.gh_pr({ state = "all" }) end, {desc = "GitHub Pull Requests (all)"})

map("n", "<leader>mc", metals.commands, { desc = "metals commands" })

map("n", "<leader>o", "<cmd>Outline<CR>", { desc = "outline" })

map("n", "<leader>sf", metals.run_scalafix, { desc = "scala fix run" })

vim.filetype.add({
	extension = {
		["http"] = "http",
	},
})

