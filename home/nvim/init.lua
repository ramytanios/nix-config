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

-- keymaps
local map = vim.keymap.set
local trouble = require("trouble")
local conform = require("conform")
local gitsigns = require("gitsigns")
local todo = require("todo-comments")
local flash = require("flash")
local telescope_builtin = require("telescope.builtin")
local telescope = require("telescope")
local oil = require("oil")

map("i", "jk", "<ESC>", { desc = "insert to visual mode" })

map("i", "jj", "<ESC>", { desc = "insert to visual mode" })

map("i", "kj", "<ESC>", { desc = "insert to visual mode" })

map("v", "J", ":m '>+1<CR>gv=gv")

map("v", "K", ":m '<-2<CR>gv=gv")

map("n", "<leader>sv", "<C-w>v", { desc = "split window vertically" })

map("n", "<leader>ss", "<C-w>s", { desc = "split window horizontal" })

map("n", "<leader>se", "<C-w>=", { desc = "make split equal width" })

map("n", "<leader>+", "<C-a>", { desc = "increment number" })

map("n", "<leader>-", "<C-x>", { desc = "decrement number" })

map("n", "<leader>sx", ":close<CR>", { desc = "close current split" })

map("n", "<leader>cf", "<cmd>edit $MYVIMRC<CR>", { desc = "open init.lua" })

map("n", "-", oil.open, { desc = "browse parent directory" })

map("n", "<leader>tw", "<cmd>Trouble diagnostics toggle<cr>", { desc = "trouble work diagnostics" })

map("n", "<leader>td", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", { desc = "trouble document diagnostics" })

map("n", "<leader>ll", function() trouble.toggle("loclist") end, { desc = "trouble loclist" })

map("n", "<leader>qf", function() trouble.toggle("quickfix") end, { desc = "trouble quickfix" })

map("n", "<leader>d", function() trouble.toggle("lsp_definitions") end, { desc = "trouble lsp definitions" })

map("n", "<leader>rf", function() trouble.toggle("lsp_references") end, { desc = "trouble lsp references" })

map("n", "]e", function() trouble.next({ skip_groups = true, jump = true }) end, { desc = "trouble next" })

map("n", "[e", function() trouble.previous({ skip_groups = true, jump = true }) end, { desc = "trouble previous" })

map("n", "<leader>h", vim.lsp.buf.hover, { desc = "lsp hover" })

map("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "lsp code action" })

map("n", "<leader>fd", vim.diagnostic.open_float, { desc = "diagnostic open float" })

map("n", "<leader>rn", ":IncRename ", { desc = "lsp rename" })

map("n", "<leader>fo", function() conform.format({ lsp_fallback = true, async = false, timeout_ms = 3000 }) end, { desc = "Conform / LSP format" })

map("n", "]t", todo.jump_next, { desc = "next todo comment" })

map("n", "[t", todo.jump_prev, { desc = "previous todo comment" })

map("n", "]h", gitsigns.next_hunk, { desc = "gitsigns next hunk" })

map("n", "[h", gitsigns.prev_hunk, { desc = "gitsigns previous hunk" })

map("n", "<leader>ph", gitsigns.preview_hunk, { desc = "gitsigns preview hunk" })

map("n", "<leader>rh", gitsigns.reset_hunk, { desc = "gitsigns reset hunk" })

map("n", "<leader>rb", gitsigns.reset_buffer, { desc = "gitsigns reset buffer" })

map("n", "<leader>sh", gitsigns.select_hunk, { desc = "gitsigns select hunk" })

map("n", "<leader>gd", ":DiffviewOpen<CR>", { noremap = true, desc = "open Git diff view" })

map("n", "<leader>bd", ":DiffviewOpen<SPACE>", { noremap = true, desc = "branch diff view" })

map("n", "<leader>bb", ":Git blame<CR>", { desc = "gitsigns toggle current blame" })

map("n", "<leader>gh", ":DiffviewFileHistory<CR>", { noremap = true, desc = "open git project history" })

map("n", "<leader>fh", ":DiffviewFileHistory %<CR>", { noremap = true, desc = "open git current file history" })

map("n", "<leader>gx", ":DiffviewClose<CR>", { noremap = true, desc = "close diff view" })

map({ "n", "x", "o" }, "s", flash.jump, { desc = "flash jump" })

map({ "n", "x", "o" }, "S", flash.treesitter, { desc = "flash treesitter search" })

map({ "o", "x" }, "R", flash.treesitter_search, { desc = "treesitter search" })

map("n", "<leader>of", telescope_builtin.oldfiles, { desc = "telescope old files" })

map("n", "<leader>ff", telescope_builtin.find_files, { desc = "telescope find files" })

map("n", "<leader>lg", telescope_builtin.live_grep, { desc = "telescope live grep" })

map("n", "<leader>gs", telescope_builtin.grep_string, { desc = "telescope grep string" })

map("n", "<leader>bu", telescope_builtin.buffers, { desc = "telescope buffers" })

map("n", "<leader>gc", telescope_builtin.git_commits, { desc = "telescope git commits" })

map("n", "<leader>gb", telescope_builtin.git_branches, { desc = "telescope git branches" })

map("n", "<leader>co", telescope_builtin.commands, { desc = "telescope commands" })

map("n", "<leader>gf", telescope_builtin.git_files, { desc = "telescope git files" })

map("n", "<leader>sy", telescope_builtin.symbols, { desc = "telescope symbols" })

map("n", "<leader>mc", telescope.extensions.metals.commands, { desc = "metals commands" })


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
