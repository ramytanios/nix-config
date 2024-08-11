vim.g.mapleader = " "

-- options
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

vim.cmd.nnoremap("d", '"_d') -- black hole register
vim.cmd.vnoremap("d", '"_d') -- black hole register

-- keymaps
local map = vim.keymap.set
local tree = require("nvim-tree.api")
local trouble = require("trouble")
local cf = require("conform")
local gs = require("gitsigns")
local todo = require("todo-comments")
local flash = require("flash")
local tb = require("telescope.builtin")
local tel = require("telescope")
local oil = require("oil")

-- general
map("i", "jk", "<ESC>", { desc = "Insert to Visual mode" })
map("i", "jj", "<ESC>", { desc = "Insert to Visual mode" })
map("i", "kj", "<ESC>", { desc = "Insert to Visual mode" })

map("v", "J", ":m '>+1<CR>gv=gv")
map("v", "K", ":m '<-2<CR>gv=gv")

map("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" })
map("n", "<leader>ss", "<C-w>s", { desc = "Split window horizontal" })
map("n", "<leader>se", "<C-w>=", { desc = "Make split equal width" })

map("n", "<leader>+", "<C-a>", { desc = "Increment number" })
map("n", "<leader>-", "<C-x>", { desc = "Decrement number" })

map("n", "<leader>sx", ":close<CR>", { desc = "Close current split" })
map("n", "<leader>cf", "<cmd>edit $MYVIMRC<CR>", { desc = "open init.lua" })

-- nvim tree
map("n", "<leader>tr", tree.tree.toggle, { desc = "Toggle nvim tree" })

-- oil
map("n", "-", oil.open, { desc = "Browse parent directory" })

-- trouble
map("n", "<leader>tw", "<cmd>Trouble diagnostics toggle<cr>", { desc = "Trouble work diagnostics" })
map("n", "<leader>td", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", { desc = "Trouble document diagnostics" })
map("n", "<leader>ll", function()
	trouble.toggle("loclist")
end, { desc = "Trouble loclist" })
map("n", "<leader>qf", function()
	trouble.toggle("quickfix")
end, { desc = "Trouble quickfix" })
map("n", "<leader>d", function()
	trouble.toggle("lsp_definitions")
end, { desc = "Trouble lsp definitions" })
map("n", "<leader>rf", function()
	trouble.toggle("lsp_references")
end, { desc = "Trouble lsp references" })
map("n", "]e", function()
	trouble.next({ skip_groups = true, jump = true })
end, { desc = "Trouble next" })
map("n", "[e", function()
	trouble.previous({ skip_groups = true, jump = true })
end, { desc = "Trouble previous" })

-- lsp
map("n", "<leader>h", vim.lsp.buf.hover, { desc = "Lsp hover" })
map("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Lsp code action" })
map("n", "<leader>fd", vim.diagnostic.open_float, { desc = "Diagnostic open float" })

-- inc rename
map("n", "<leader>rn", ":IncRename ", { desc = "Lsp rename" })

-- conform
map("n", "<leader>fo", function()
	cf.format({ lsp_fallback = true, async = false, timeout_ms = 3000 })
end, { desc = "Conform / LSP format" })

-- todo comments
map("n", "]t", todo.jump_next, { desc = "Next todo comment" })
map("n", "[t", todo.jump_prev, { desc = "Previous todo comment" })

-- gitsigns / fugitive / diffview
map("n", "]h", gs.next_hunk, { desc = "Gitsigns next hunk" })
map("n", "[h", gs.prev_hunk, { desc = "Gitsigns previous hunk" })
map("n", "<leader>ph", gs.preview_hunk, { desc = "Gitsigns preview hunk" })
map("n", "<leader>rh", gs.reset_hunk, { desc = "Gitsigns reset hunk" })
map("n", "<leader>rb", gs.reset_buffer, { desc = "Gitsigns reset buffer" })
map("n", "<leader>sh", gs.select_hunk, { desc = "Gitsigns select hunk" })
map("n", "<leader>gd", ":DiffviewOpen<CR>", { noremap = true, desc = "Open Git diff view" })
map("n", "<leader>bd", ":DiffviewOpen<SPACE>", { noremap = true, desc = "Branch diff view" })
map("n", "<leader>bb", ":Git blame<CR>", { desc = "Gitsigns toggle current blame" })
map("n", "<leader>gh", ":DiffviewFileHistory<CR>", { noremap = true, desc = "Open git project history" })
map("n", "<leader>fh", ":DiffviewFileHistory %<CR>", { noremap = true, desc = "Open git current file history" })
map("n", "<leader>gx", ":DiffviewClose<CR>", { noremap = true, desc = "Close diff view" })

-- flash
map({ "n", "x", "o" }, "s", flash.jump, { desc = "Flash jump" })
map({ "n", "x", "o" }, "S", flash.treesitter, { desc = "Flash treesitter search" })
map({ "o", "x" }, "R", flash.treesitter_search, { desc = "Treesitter Search" })

-- telescope
map("n", "<leader>of", tb.oldfiles, { desc = "Telescope old files" })
map("n", "<leader>ff", tb.find_files, { desc = "Telescope find files" })
map("n", "<leader>lg", tb.live_grep, { desc = "Telescope live grep" })
map("n", "<leader>gs", tb.grep_string, { desc = "Telescope grep string" })
map("n", "<leader>bu", tb.buffers, { desc = "Telescope buffers" })
map("n", "<leader>gc", tb.git_commits, { desc = "Telescope git commits" })
map("n", "<leader>gb", tb.git_branches, { desc = "Telescope git branches" })
map("n", "<leader>co", tb.commands, { desc = "Telescope commands" })
map("n", "<leader>gf", tb.git_files, { desc = "Telescope git files" })
map("n", "<leader>sy", tb.symbols, { desc = "Telescope symbols" })
map("n", "<leader>mc", tel.extensions.metals.commands, { desc = "Metals commands" })
map("n", "<leader>cs", function()
	tb.colorscheme({ enable_preview = true })
end, { desc = "Select colorscheme" })

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
