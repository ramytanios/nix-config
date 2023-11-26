require("oil").setup({
	keymaps = { ["<CR>"] = "actions.select" },
	use_default_keymaps = false,
	view_options = {
		show_hidden = true,
		is_always_hidden = function(name, _)
			return name == ".."
		end,
	},
})
