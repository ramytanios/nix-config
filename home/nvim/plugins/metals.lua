local api = vim.api

local metals_config = require("metals").bare_config()

metals_config.init_options = {
	statusBarProvider = "off",
	icons = "unicode",
}

metals_config.settings = {
	defaultBspToBuildTool = true,
	useGlobalExecutable = true,
	superMethodLensesEnabled = true,
	metalsBinaryPath = metalsBinary, -- defined in nvim.nix
}

metals_config.capabilities = require("blink.cmp").get_lsp_capabilities()

local nvim_metals_group = api.nvim_create_augroup("nvim-metals", { clear = true })

api.nvim_create_autocmd("FileType", {
	pattern = { "scala", "sbt", "java" },
	callback = function()
		require("metals").initialize_or_attach(metals_config)
	end,
	group = nvim_metals_group,
})
