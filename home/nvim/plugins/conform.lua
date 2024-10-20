require("conform").setup({
	formatters_by_ft = {
		python = { "ruff_format" },
		-- cpp = { "clang_format" }, # we prefer using clangd formatting
		lua = { "stylua" },
		bash = { "shfmt" },
		typescript = { "prettier" },
		javascript = { "prettier" },
		css = { "prettier" },
		json = { "prettier" },
		html = { "prettier" },
		xml = { "xmlformatter" },
		typ = { "typstfmt" },
	},
	-- format_on_save = {
	-- 	lsp_fallback = true,
	-- 	async = false,
	-- 	timeout_ms = 1000,
	-- },
})
