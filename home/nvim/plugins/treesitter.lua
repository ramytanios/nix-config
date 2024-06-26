require("nvim-treesitter.configs").setup({
	highlight = { enable = true },

	indent = { enable = true },

	--load the plugin only when opening a buffer
	--for an already existing file or for a new one
	event = { "BufReadPre", "BufNewFile" },

	-- enable incremental selection
	incremental_selection = {
		enable = true,
		keymaps = {
			init_selection = "<C-space>",
			node_incremental = "<C-space>",
			scope_incremental = false,
			node_decremental = "<bs>",
		},
	},
})
