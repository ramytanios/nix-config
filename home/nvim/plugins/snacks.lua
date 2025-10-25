local snacks = require("snacks")
snacks.setup({
	scroll = {
		enabled = false,
		animate = {
			duration = { step = 10, total = 1000 },
			easing = "linear",
		},
	},
	words = { enabled = true },
	indent = { enabled = true },
	bigfile = { enabled = true },
	input = { enabled = true },
	notifier = { enabled = true },
	quickfile = { enabled = true },
	picker = { main = { file = false, current = true } },
})
