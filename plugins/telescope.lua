local telescope = require("telescope")
local ta = require("telescope.actions")
telescope.setup({
	defaults = {
		layout_strategy = "vertical",
		mappings = {
			i = {
				["<C-k>"] = ta.move_selection_previous,
				["<C-j>"] = ta.move_selection_next,
			},
		},
	},
})
telescope.load_extension("ui-select")
telescope.load_extension("fzf")
-- telescope.load_extension("emoji")
