local snacks = require("snacks")
snacks.setup({
	scroll = { enabled = true, animate = { duration = { step = 10, total = 1000 }, easing = "linear" } },
	words = { enabled = true },
	indent = { enabled = true },
	statuscolumn = { enabled = true },
	bigfile = { enabled = true },
	input = { enabled = true },
	notifier = { enabled = true },
	quickfile = { enabled = true },
})
