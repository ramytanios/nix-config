local lint = require("lint")
lint.linters_by_ft = {
	python = { "pylint" },
	cpp = { "cpplint" },
	typescript = { "eslint_d" },
	javascript = { "eslint_d" },
}
local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })
vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
	group = lint_augroup,
	callback = function()
		lint.try_lint()
	end,
})
