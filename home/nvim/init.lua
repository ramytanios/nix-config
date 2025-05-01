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

local fzf = require("fzf-lua")

local trouble = require("trouble")

local metals = require("metals")

local precognition = require("precognition")

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

map("n", "<leader>ca", fzf.lsp_code_actions, { desc = "lsp code actions" })

map("n", "<leader>rn", vim.lsp.buf.rename, { desc = "lsp rename" })

map("n", "<leader>fd", vim.diagnostic.open_float, { desc = "diagnostic open float" })

map("n", "<leader>fo", function()
	conform.format({ lsp_fallback = true, async = false, timeout_ms = 3000 })
end, { desc = "Conform / LSP format" })

map("n", "]t", todo.jump_next, { desc = "next todo comment" })

map("n", "[t", todo.jump_prev, { desc = "previous todo comment" })

map({ "n", "x", "o" }, "s", flash.jump, { desc = "flash jump" })

map({ "n", "x", "o" }, "S", flash.treesitter, { desc = "flash treesitter search" })

map({ "o", "x" }, "R", flash.treesitter_search, { desc = "treesitter search" })

map("n", "<leader>ff", fzf.files, { desc = "find files" })

map("n", "<leader>lg", fzf.live_grep, { desc = "live grep" })

map("n", "<leader>gs", fzf.grep_cword, { desc = "grep word under cursor" })

-- git keymaps
map("n", "<leader>Gh", ":DiffviewFileHistory<CR>", { noremap = true, desc = "Git history" })
map("n", "<leader>Gfh", ":DiffviewFileHistory %<CR>", { noremap = true, desc = "Git file history" })
map("n", "<leader>Gq", ":DiffviewClose<CR>", { noremap = true, desc = "Git close diffview" })
map("n", "<leader>Gph", gitsigns.preview_hunk, { desc = "Git preview hunk" })
map("n", "<leader>Grh", gitsigns.reset_hunk, { desc = "Git reset hunk" })
map("n", "<leader>Grb", gitsigns.reset_buffer, { desc = "Git reset buffer" })
map("n", "<leader>Gsh", gitsigns.select_hunk, { desc = "Git select hunk" })
map("n", "<leader>Gd", ":DiffviewOpen<CR>", { noremap = true, desc = "Git diff" })
map("n", "<leader>Gdb", ":DiffviewOpen<SPACE>", { noremap = true, desc = "Git diff branch" })
map("n", "<leader>Gb", ":Git blame<CR>", { desc = "Git blame" })
map("n", "]h", gitsigns.next_hunk, { desc = "gitsigns next hunk" })
map("n", "[h", gitsigns.prev_hunk, { desc = "gitsigns previous hunk" })
-- map("n", "<leader>Gc", fzf.git_commits, { desc = "git commits" })
-- map("n", "<leader>Gf", fzf.git_files, { desc = "git files" })
-- map("n", "<leader>Gb", fzf.git_branches, { desc = "git branches" })

map("n", "<leader>co", fzf.commands, { desc = "commands" })

map("n", "<leader>cs", fzf.colorschemes, { desc = "colorschemes" })

map("n", "<leader>mc", metals.commands, { desc = "metals commands" })

map("n", "<leader>o", "<cmd>Outline<CR>", { desc = "outline" })

map("n", "<leader>sf", metals.run_scalafix, { desc = "scala fix run" })

map("n", "<leader>pc", precognition.toggle, { desc = "toggle precognition" })

vim.filetype.add({
	extension = {
		["http"] = "http",
	},
})

--map("n", "<leader>gb", function() Snacks.gitbrowse() end, { desc = "git branches" })
-- map("n", "<leader>re", ":Rest run", { noremap = true, desc = "Rest run" })
-- map("n", "<leader>cs", function() telescope_builtin.colorscheme({ enable_preview = true }) end, { desc = "select colorscheme" })
-- map("n", "<leader>gd", gs.diffthis, { desc = "Gitsigns diff this" })
-- map("n", "<leader>tt", trouble.toggle, { desc = "Toggle trouble" })
-- map("n", "<leader>ds", vim.lsp.buf.document_symbol, { desc = "Lsp document symbol" })
-- map("n", "<leader>ws", vim.lsp.buf.workspace_symbol, { desc = "Lsp workspace symbol" })
-- map("n", "<leader>i", vim.lsp.buf.implementation, { desc = "Lsp implementation" })
-- map("n", "<leader>gs", tb.git_status, { desc = "Telescope git status" })
-- map("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Lsp rename" })
-- map("n", "<leader>sh", vim.lsp.buf.signature_help, { desc = "Lsp signature help" })
-- map("n", "<leader>dvx", ":DiffviewClose<CR>", { noremap = true, desc = "" })
-- map("n", "<leader>fh", ":DiffviewFileHistory %<CR>", { noremap = true, desc = "" })
-- map("n", "<leader>bd", function()
-- 	vim.ui.input({ prompt = "Enter branch name" }, function(branch)
-- 		local command = ":DiffviewOpen " .. branch
-- 		vim.cmd(command)
-- 	end)
-- end, { noremap = true, desc = "branch diff view" })
