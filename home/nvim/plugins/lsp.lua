local lsp_config = require("lspconfig")

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)
lsp_config.util.default_config =
	vim.tbl_extend("force", lsp_config.util.default_config, { capabilities = capabilities })

-- NOTE: haskell-language-server is managed by haskell-tools.nvim
-- lsp_config.hls.setup {}

-- NOTE: scala metals is managed by nvim-metals
-- lsp_config.metals.setup {}

lsp_config.bashls.setup({})
lsp_config.html.setup({})
lsp_config.ruff_lsp.setup({})
lsp_config.smithy_ls.setup({})
lsp_config.tsserver.setup({})

lsp_config.nil_ls.setup({
	settings = {
		["nil"] = {
			formatting = {
				command = { "nixfmt" },
			},
		},
	},
})

lsp_config.lua_ls.setup({
	settings = {
		Lua = {
			format = {
				enable = false, -- we prefer stylua via conform
			},
			runtime = {
				-- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
				version = "LuaJIT",
			},
			diagnostics = {
				-- Get the language server to recognize the `vim` global
				globals = { "vim" },
			},
			workspace = {
				-- Make the server aware of Neovim runtime files
				library = vim.api.nvim_get_runtime_file("", true),
			},
			-- Do not send telemetry data containing a randomized but unique identifier
			telemetry = {
				enable = false,
			},
		},
	},
})
