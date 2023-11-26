-- KEYMAPS
local keymap = vim.keymap -- for conciseness
keymap.set("i", "jk", "<ESC>")
keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
keymap.set("n", "x", '"_x')
keymap.set("v", "J", ":m '>+1<CR>gv=gv")
keymap.set("v", "K", ":m '<-2<CR>gv=gv")
keymap.set("n", "fo", ":join<CR>")
keymap.set("n", "<leader>cf", "<cmd>edit $MYVIMRC<CR>")

keymap.set("n", "<leader>tr", function()
	require("nvim-tree.api").tree.toggle()
end)

-- windows plit
keymap.set("n", "<leader>noh", ":nohl<CR>") -- example /keymap and then clear highlight
keymap.set("n", "<leader>sv", "<C-w>v") -- split window vertically
keymap.set("n", "<leader>ss", "<C-w>s") -- slit window horizontal
keymap.set("n", "<leader>se", "<C-w>=") -- make split equal width
keymap.set("n", "<leader>sx", ":close<CR>") -- close current split

keymap.set("n", "<leader>tt", "<cmd>TroubleToggle<cr>")
keymap.set("n", "<leader>tw", "<cmd>TroubleToggle workspace_diagnostics<cr>")
keymap.set("n", "<leader>td", "<cmd>TroubleToggle document_diagnostics<cr>")
keymap.set("n", "<leader>tl", "<cmd>TroubleToggle loclist<cr>")
keymap.set("n", "<leader>tq", "<cmd>TroubleToggle quickfix<cr>")
keymap.set("n", "<leader>d", "<cmd>TroubleToggle lsp_definitions<cr>")
keymap.set("n", "<leader>r", "<cmd>TroubleToggle lsp_references<cr>")
keymap.set("n", "<leader>tn", function()
	require("trouble").next({ skip_groups = true, jump = true })
end)
keymap.set("n", "<leader>tp", function()
	require("trouble").previous({ skip_groups = true, jump = true })
end)
keymap.set("n", "<leader>h", vim.lsp.buf.hover)
keymap.set("n", "<leader>i", vim.lsp.buf.implementation)
keymap.set("n", "<leader>s", vim.lsp.buf.document_symbol)
keymap.set("n", "<leader>ws", vim.lsp.buf.workspace_symbol)
keymap.set("n", "<leader>sh", vim.lsp.buf.signature_help)
keymap.set("n", "<leader>rn", vim.lsp.buf.rename)
keymap.set("n", "<leader>f", function()
	require("conform").format({ lsp_fallback = true, async = false, timeout_ms = 3000 })
end)
keymap.set("n", "<leader>a", vim.lsp.buf.code_action)

-- gitsigns
local gitsigns = require("gitsigns")
keymap.set("n", "<leader>nh", gitsigns.next_hunk)
keymap.set("n", "<leader>ph", gitsigns.preview_hunk)
keymap.set("n", "<leader>prh", gitsigns.prev_hunk)
keymap.set("n", "<leader>rh", gitsigns.reset_hunk)
keymap.set("n", "<leader>gh", gitsigns.select_hunk)
keymap.set("n", "<leader>lb", gitsigns.toggle_current_line_blame)

-- telescope
local tb = require("telescope.builtin")
keymap.set("n", "<leader>?", tb.oldfiles)
keymap.set("n", "<leader>ff", tb.find_files)
keymap.set("n", "<leader>lg", tb.live_grep)
keymap.set("n", "<leader>gr", tb.grep_string)
keymap.set("n", "<leader>fb", tb.buffers)
keymap.set("n", "<leader>ht", tb.help_tags)
keymap.set("n", "<leader>fda", tb.diagnostics)
keymap.set("n", "<leader>gc", tb.git_commits)
keymap.set("n", "<leader>gb", tb.git_branches)
keymap.set("n", "<leader>gs", tb.git_status)
keymap.set("n", "<leader>co", tb.commands)
keymap.set("n", "<leader>ts", tb.treesitter)
keymap.set("n", "<leader>gf", tb.git_files)
keymap.set("n", "<leader>mc", require("telescope").extensions.metals.commands)
keymap.set("n", "<leader>cs", function()
	tb.colorscheme({ enable_preview = true })
end)
vim.api.nvim_set_keymap("n", "<leader>bb", ":Telescope file_browser<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>em", ":Telescope emoji<CR>", { noremap = true })

-- diagnostic in a float
keymap.set("n", "<leader>fd", function()
	vim.diagnostic.open_float()
end)

-- todo
keymap.set("n", "<leader>to", "<cmd>TodoTelescope<cr>", { silent = true, noremap = true })

-- oil nvim
keymap.set("n", "-", require("oil").open)

-- diff view
vim.api.nvim_set_keymap("n", "<leader>dv", ":DiffviewOpen<SPACE>", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>dvx", ":DiffviewClose<CR>", { noremap = true })

-- VIM OPTIONS
local opt = vim.opt -- for conciseness
-- line numbers
opt.relativenumber = true
opt.number = true
-- use Xj to navigate relatively
-- tabs and indentation
opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.autoindent = true
-- line wrapping
opt.wrap = false
-- search settings
opt.ignorecase = true
opt.smartcase = true
-- cursor line
opt.cursorline = true
-- appearance
opt.termguicolors = true
opt.background = "dark"
opt.signcolumn = "yes"
-- backspace
opt.backspace = "indent,eol,start"
-- clipboard
opt.clipboard:append("unnamedplus")
-- split windows
opt.splitright = true -- vertical split
opt.splitbelow = true -- horizontal split
opt.swapfile = false

vim.cmd("colorscheme tokyonight-storm")
