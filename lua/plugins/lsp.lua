-- ============================================================================
-- LSP Configuration for Neovim 0.11+
-- Uses native vim.lsp.config() and vim.lsp.enable() instead of lsp-zero
-- ============================================================================

return {
	-- Mason: UI for installing and managing LSP servers, formatters, linters
	{
		"mason-org/mason.nvim",
		config = function()
			require("mason").setup()
		end,
	},

	-- Bridge between Mason and native LSP
	{
		"mason-org/mason-lspconfig.nvim",
		dependencies = { "mason-org/mason.nvim" },
		config = function()
			require("mason-lspconfig").setup({
				-- Automatically install these language servers
				ensure_installed = { "lua_ls", "gopls" },
			})
		end,
	},

	-- nvim-lspconfig: Provides default configurations for LSP servers
	-- Neovim 0.11+ can use these via vim.lsp.config()
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"mason-org/mason.nvim",
			"mason-org/mason-lspconfig.nvim",
		},
		config = function()
			-- ========================================
			-- LSP Server Configurations
			-- ========================================

			-- Global LSP settings that apply to all servers
			-- The '*' means "apply to all LSP servers"
			vim.lsp.config("*", {
				-- Capabilities tell the server what features Neovim supports
				capabilities = require("cmp_nvim_lsp").default_capabilities(),

				-- on_attach runs when LSP attaches to a buffer
				on_attach = function(client, bufnr)
					-- Helper function to set keymaps only in LSP buffers
					local function map(mode, lhs, rhs, desc)
						vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
					end

					-- LSP keymaps (these only work when LSP is active)
					map("n", "gd", vim.lsp.buf.definition, "Go to definition")
					map("n", "gD", vim.lsp.buf.declaration, "Go to declaration")
					map("n", "gr", vim.lsp.buf.references, "Show references")
					map("n", "gi", vim.lsp.buf.implementation, "Go to implementation")
					map("n", "gh", vim.lsp.buf.hover, "Show hover information")
					map("n", "K", vim.lsp.buf.hover, "Show hover information")
					map("n", "<leader>rn", vim.lsp.buf.rename, "Rename symbol")
					map("n", "<leader>ca", vim.lsp.buf.code_action, "Code action")
					map("n", "<leader>gf", vim.lsp.buf.format, "Format code")
				end,
			})

			-- ========================================
			-- Server-specific configurations
			-- ========================================

			-- Lua Language Server (lua_ls)
			vim.lsp.config("lua_ls", {
				settings = {
					Lua = {
						runtime = {
							version = "LuaJIT", -- Use LuaJIT for Neovim
						},
						diagnostics = {
							globals = { "vim" }, -- Recognize 'vim' as a global variable
						},
						workspace = {
							-- Make server aware of Neovim runtime files
							library = vim.api.nvim_get_runtime_file("", true),
							checkThirdParty = false, -- Don't ask about third-party libraries
						},
						telemetry = {
							enable = false, -- Disable telemetry
						},
					},
				},
			})

			-- Go Language Server (gopls)
			vim.lsp.config("gopls", {
				settings = {
					gopls = {
						semanticTokens = true, -- Enable semantic highlighting
					},
				},
			})

			-- ========================================
			-- Enable LSP servers
			-- ========================================
			-- This tells Neovim to activate these servers for their filetypes
			vim.lsp.enable({ "lua_ls", "gopls" })

			-- ========================================
			-- Diagnostic configuration
			-- ========================================
			vim.diagnostic.config({
				virtual_text = true, -- Show diagnostics inline
				signs = true, -- Show signs in the gutter
				update_in_insert = false, -- Don't update diagnostics while typing
				underline = true, -- Underline diagnostic text
				severity_sort = true, -- Sort by severity
			})

			-- Customize diagnostic signs in the gutter
			local signs = { Error = "✘", Warn = "▲", Hint = "⚑", Info = "»" }
			for type, icon in pairs(signs) do
				local hl = "DiagnosticSign" .. type
				vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
			end
		end,
	},

	-- ============================================================================
	-- Autocompletion with nvim-cmp
	-- ============================================================================
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			-- Snippet engine (required by nvim-cmp)
			"L3MON4D3/LuaSnip",

			-- Completion sources
			"hrsh7th/cmp-nvim-lsp", -- LSP completions
			"hrsh7th/cmp-buffer", -- Buffer completions
			"hrsh7th/cmp-path", -- File path completions
			"hrsh7th/cmp-nvim-lua", -- Neovim Lua API completions
			"hrsh7th/cmp-calc", -- Math calculations
			"f3fora/cmp-spell", -- Spell check suggestions

			-- Icons in completion menu
			"onsails/lspkind.nvim",
		},
		config = function()
			local cmp = require("cmp")
			local lspkind = require("lspkind")

			-- Enable spell checking
			vim.opt.spell = true
			vim.opt.spelllang = { "en_us" }

			cmp.setup({
				-- Snippet configuration
				snippet = {
					expand = function(args)
						require("luasnip").lsp_expand(args.body)
					end,
				},

				-- Completion window appearance
				window = {
					completion = cmp.config.window.bordered(),
					documentation = cmp.config.window.bordered(),
				},

				-- Keymaps for completion menu
				mapping = cmp.mapping.preset.insert({
					["<Tab>"] = cmp.mapping.select_next_item(),
					["<S-Tab>"] = cmp.mapping.select_prev_item(),
					["<C-Space>"] = cmp.mapping.complete(), -- Trigger completion
					["<C-e>"] = cmp.mapping.abort(), -- Close completion
					["<CR>"] = cmp.mapping.confirm({ select = false }), -- Confirm selection
					["<Space>"] = cmp.mapping.confirm({ select = false }),

					-- Custom Escape behavior: close completion and exit insert mode
					["<Esc>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.abort()
							vim.api.nvim_input("<esc>")
						else
							fallback()
						end
					end),
				}),

				-- Completion sources (in order of priority)
				sources = cmp.config.sources({
					{ name = "nvim_lsp", max_item_count = 10 }, -- LSP suggestions (top priority)
					-- {
					-- 	name = "spell",
					-- 	option = {
					-- 		keep_all_entries = false,
					-- 		enable_in_context = function()
					-- 			return true
					-- 		end,
					-- 	},
					-- },
					-- { name = "buffer" }, -- Words from current buffer
				}, {
					{ name = "path" }, -- File paths
					{ name = "nvim_lua" }, -- Neovim Lua API
					{ name = "calc" }, -- Calculator
				}),

				-- Formatting: add icons and customize appearance
				formatting = {
					fields = { "kind", "abbr", "menu" },
					format = function(entry, vim_item)
						local kind = lspkind.cmp_format({
							mode = "symbol_text",
							maxwidth = 60,
						})(entry, vim_item)

						-- Split kind into icon and text
						local strings = vim.split(kind.kind, "%s", { trimempty = true })
						kind.kind = strings[1] or ""
						-- Uncomment to show source in menu:
						-- kind.menu = '    (' .. (strings[2] or '') .. ')'

						return kind
					end,
				},
			})

			-- Special completion for git commit messages
			cmp.setup.filetype("gitcommit", {
				sources = cmp.config.sources({
					{ name = "buffer" },
				}),
			})
		end,
	},
}
