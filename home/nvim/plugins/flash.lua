require("flash").setup({
	label = { style = "inline", rainbow = { enabled = true } },
	modes = { char = { keys = {
		"f",
		"F",
		"t",
		"T",
		[";"] = "<TAB>",
		[","] = "`",
	} } },
})
