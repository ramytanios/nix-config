require("conform").setup({
	formatters = {
		pg_fmt = {
			command = "pg_format",
			args = { "-" },
			stdin = true,
		},
	},
	formatters_by_ft = {
		python = { "ruff_format", "ruff_fix", "ruff_organize_imports" },
		lua = { "stylua" },
		bash = { "shfmt" },
		yml = { "yamlfmt" },
		sql = { "pg_fmt" },
		nix = { "nixfmt" },
		justfile = { "just" },
		css = { "prettierd", "stylelint" },
		html = { "prettierd" },
		javascript = { "prettierd" },
		json = { "jq" },
		markdown = { "prettierd" },
	},
})
