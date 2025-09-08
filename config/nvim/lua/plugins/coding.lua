local border = {
	{ "🭽", "FloatBorder" },
	{ "▔", "FloatBorder" },
	{ "🭾", "FloatBorder" },
	{ "▕", "FloatBorder" },
	{ "🭿", "FloatBorder" },
	{ "▁", "FloatBorder" },
	{ "🭼", "FloatBorder" },
	{ "▏", "FloatBorder" },
}
-- LSP settings (for overriding per client)
local handlers = {

	["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = border }),
	["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = border }),
}

return {
	-- auto pairs
	{
		"echasnovski/mini.nvim",
		event = "VeryLazy",
		opts = {
			modes = { insert = true, command = true, terminal = false },
			-- skip autopair when next character is one of these
			skip_next = [=[[%w%%%'%[%"%.%`%$]]=],
			-- skip autopair when the cursor is inside these treesitter nodes
			skip_ts = { "string" },
			-- skip autopair when next character is closing pair
			-- and there are more closing pairs than opening pairs
			skip_unbalanced = true,
			-- better deal with markdown code blocks
			markdown = true,
		},
		config = function()
			require("mini.pairs").setup()
		end,
	},

	{
		{
			"folke/lazydev.nvim",
			ft = "lua", -- only load on lua files
			opts = {
				library = {
					-- See the configuration section for more details
					-- Load luvit types when the `vim.uv` word is found
					{ path = "luvit-meta/library", words = { "vim%.uv" } },
				},
			},
		},
		{ "Bilal2453/luvit-meta", lazy = true }, -- optional `vim.uv` typings
	},

	-- {
	-- 	"hrsh7th/nvim-cmp",
	-- 	event = { "BufNewFile", "BufReadPost", "BufWritePost", "LspAttach" },
	-- 	dependencies = {
	-- 		"hrsh7th/cmp-buffer",
	-- 		"hrsh7th/cmp-nvim-lsp",
	-- 		"hrsh7th/cmp-nvim-lua",
	-- 		"saadparwaiz1/cmp_luasnip",
	-- 		"L3MON4D3/LuaSnip",
	-- 	},
	-- 	config = function()
	-- 		local cmp = require("cmp")
	-- 		local luasnip = require("luasnip")

	-- 		local kind_icons = {
	-- 			Text = "",
	-- 			Method = "m",
	-- 			Function = "󰊕",
	-- 			Constructor = "",
	-- 			Field = "",
	-- 			Variable = "",
	-- 			Class = "",
	-- 			Interface = "",
	-- 			Module = "",
	-- 			Property = " ",
	-- 			Unit = "",
	-- 			Value = "󰎠",
	-- 			Enum = "",
	-- 			Keyword = "󰌋",
	-- 			Snippet = "",
	-- 			Color = "󰏘",
	-- 			File = "󰈙",
	-- 			Reference = "",
	-- 			Folder = "󰉋",
	-- 			EnumMember = "",
	-- 			Constant = "󰏿",
	-- 			Struct = "",
	-- 			Event = "",
	-- 			Operator = "󰆕",
	-- 			TypeParameter = " ",
	-- 		}

	-- 		local borderstyle = {
	-- 			border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
	-- 			winhighlight = "Normal:CmpPmenu,CursorLine:PmenuSel,Search:None",
	-- 		}

	-- 		cmp.setup({
	-- 			snippet = {
	-- 				expand = function(args)
	-- 					luasnip.lsp_expand(args.body)
	-- 				end,
	-- 			},
	-- 			mapping = cmp.mapping.preset.insert({
	-- 				["<M-o>"] = cmp.mapping.scroll_docs(4),
	-- 				["<M-i>"] = cmp.mapping.scroll_docs(-4),
	-- 				["<M-k>"] = cmp.mapping.select_prev_item(),
	-- 				["<M-j>"] = cmp.mapping.select_next_item(),
	-- 				["<C-Space>"] = cmp.mapping.complete({}),
	-- 				["<C-e>"] = cmp.mapping({
	-- 					i = cmp.mapping.abort(),
	-- 					c = cmp.mapping.close(),
	-- 				}),
	-- 				["<CR>"] = cmp.mapping.confirm({
	-- 					select = true,
	-- 					behavior = cmp.ConfirmBehavior.Replace,
	-- 				}),
	-- 			}),

	-- 			formatting = {
	-- 				fields = { "kind", "abbr", "menu" },
	-- 				format = function(entry, vim_item)
	-- 					vim_item.menu = ({
	-- 						nvim_lsp = "[LSP]",
	-- 						luasnip = "[Snip]",
	-- 					})[entry.source.name]

	-- 					vim_item.kind = string.format("%s", kind_icons[vim_item.kind])
	-- 					return vim_item
	-- 				end,
	-- 			},
	-- 			sources = cmp.config.sources({
	-- 				{ name = "nvim_lsp" },
	-- 				{ name = "luasnip" },
	-- 				{ name = "lazydev" },
	-- 				{ name = "minuet" },
	-- 			}),
	-- 			duplicates = {
	-- 				nvim_lsp = 1,
	-- 				luasnip = 1,
	-- 				buffer = 1,
	-- 				path = 1,
	-- 			},
	-- 			window = {
	-- 				completion = borderstyle,
	-- 				documentation = borderstyle,
	-- 			},
	-- 			experimental = {
	-- 				ghost_text = false,
	-- 				native_menu = false,
	-- 			},
	-- 		})
	-- 	end,
	-- },
	{
		"saghen/blink.cmp",
		-- optional: provides snippets for the snippet source
		dependencies = { "rafamadriz/friendly-snippets" },

		-- use a release tag to download pre-built binaries
		version = "1.*",
		-- AND/OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
		-- build = 'cargo build --release',
		-- If you use nix, you can build from source using latest nightly rust with:
		-- build = 'nix run .#build-plugin',

		opts = {
			appearance = {
				-- sets the fallback highlight groups to nvim-cmp's highlight groups
				-- useful for when your theme doesn't support blink.cmp
				-- will be removed in a future release, assuming themes add support
				use_nvim_cmp_as_default = false,
				-- set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
				-- adjusts spacing to ensure icons are aligned
				nerd_font_variant = "mono",
			},

			completion = {
				accept = {
					-- experimental auto-brackets support
					auto_brackets = {
						enabled = true,
					},
				},
				menu = {
					draw = {
						treesitter = { "lsp" },
						gap = 2,
					},
					border = "rounded",
					winhighlight = "Normal:Normal,FloatBorder:FloatBorder,CursorLine:BlinkCmpMenuSelection,Search:None",
					auto_Show = false,
				},
				documentation = {
					auto_show = false,
					auto_show_delay_ms = 200,
					window = {
						border = "rounded",
						winhighlight = "Normal:Normal,FloatBorder:FloatBorder,CursorLine:BlinkCmpDocCursorLine,Search:None",
					},
				},
				-- ghost_text = {
				-- 	enabled = vim.g.ai_cmp,
				-- },
			},

			-- experimental signature help support
			-- signature = { enabled = true },

			sources = {
				-- adding any nvim-cmp sources here will enable them
				-- with blink.compat
				compat = {},
				default = { "lsp", "path", "snippets", "buffer" },
			},

			cmdline = {
				enabled = false,
			},

			keymap = {
				preset = "none",

				["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
				["<C-y>"] = { "select_and_accept" },
				["<C-e>"] = { "hide" },

				["<C-k>"] = { "select_prev", "fallback_to_mappings" },
				["<C-j>"] = { "select_next", "fallback_to_mappings" },

				["<C-b>"] = { "scroll_documentation_up", "fallback" },
				["<C-f>"] = { "scroll_documentation_down", "fallback" },

				["<Tab>"] = { "snippet_forward", "fallback" },
				["<S-Tab>"] = { "snippet_backward", "fallback" },
			},
		},
		opts_extend = { "sources.default" },
	},

	{
		"neovim/nvim-lspconfig",
		config = function()
			local lspconfig = require("lspconfig")
			local capabilities = require("blink.cmp").get_lsp_capabilities()
			--local capabilities = require("cmp_nvim_lsp").default_capabilities()
			local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }

			for type, icon in pairs(signs) do
				local hl = "DiagnosticSign" .. type
				vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
			end
			lspconfig.gopls.setup({
				capabilities = capabilities,
			})
			lspconfig.lua_ls.setup({
				capabilities = capabilities,
				handlers = handlers,
			})
			lspconfig.clangd.setup({
				capabilities = capabilities,
			})
			lspconfig.ts_ls.setup({
				capabilities = capabilities,
			})
			lspconfig.vls.setup({
				capabilities = capabilities,
			})
			lspconfig.rust_analyzer.setup({
				capabilities = capabilities,
			})
		end,
	},

	{
		"sontungexpt/better-diagnostic-virtual-text",
		config = function(_)
			require("better-diagnostic-virtual-text").setup(opts)
		end,
	},
	{
		"luckasRanarison/tailwind-tools.nvim",
		name = "tailwind-tools",
		build = ":UpdateRemotePlugins",
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
		},
		opts = {}, -- your configuration
	},
}
