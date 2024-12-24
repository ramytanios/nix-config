require("conform").setup({
	formatters = {
		pg_fmt = {
			command = "pg_format",
			args = { "-" },
			stdin = true,
		},
	},
	formatters_by_ft = {
		python = { "ruff_format", "isort" },
		lua = { "stylua" },
		bash = { "shfmt" },
		yml = { "yamlfmt" },
		sql = { "pg_fmt" },
	},
})
