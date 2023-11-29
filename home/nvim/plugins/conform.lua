require("conform").setup({
	formatters_by_ft = {
		python = { "ruff" },
		cpp = { "clang_format" },
		lua = { "stylua" },
		bash = { "shfmt" },
		typescript = { "prettier" },
		javascript = { "prettier" },
		css = { "prettier" },
		json = { "prettier" },
		html = { "prettier" },
		xml = { "xmlformatter" },
    nix = { "nixfmt "}
	},
	-- format_on_save = {
	-- 	lsp_fallback = true,
	-- 	async = false,
	-- 	timeout_ms = 1000,
	-- },
})
