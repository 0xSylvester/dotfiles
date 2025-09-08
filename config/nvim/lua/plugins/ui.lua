local dashboard_header = [[
        ▀████▀▄▄              ▄█ 
          █▀    ▀▀▄▄▄▄▄    ▄▄▀▀█ 
  ▄        █          ▀▀▀▀▄  ▄▀  
 ▄▀ ▀▄      ▀▄              ▀▄▀  
▄▀    █     █▀   ▄█▀▄      ▄█    
▀▄     ▀▄  █     ▀██▀     ██▄█   
 ▀▄    ▄▀ █   ▄██▄   ▄  ▄  ▀▀ █  
  █  ▄▀  █    ▀██▀    ▀▀ ▀▀  ▄▀  
 █   █  █      ▄▄           ▄▀   
]]
return {
	{
		"nvim-lualine/lualine.nvim",
		--dependencies = { "nvim-tree/nvim-web-devicons" },
		dependencies = { "echasnovski/mini.nvim" },
		opts = {
			options = {
				icons_enabled = true,
				theme = "nightfly",
				component_separators = { left = "", right = "" },
				section_separators = { left = "", right = "" },
				disabled_filetypes = { statusline = { "dashboard", "alpha", "ministarter" } },
			},

			sections = {
				lualine_a = { "mode" }, --"mode" },
				lualine_b = { "branch", "diff", "diasnostics", "filename" },
				lualine_c = { "" },
				lualine_x = { "fileformat", "filetype" },
				lualine_y = { "" },
				lualine_z = { "location" },
			},
			diagnostic = {
				"diagnostics",
				symbols = {
					error = " ",
					warn = " ",
					info = " ",
					hint = " ",
				},
				icon = " ",
			},
		},

		config = function()
			require("mini.icons").setup()
			require("mini.icons").mock_nvim_web_devicons()
			require("lualine").setup(opts)
		end,
	},
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		dependencies = { "MunifTanjim/nui.nvim", lazy = true },
		opts = {
			commands = {
				history = {
					-- options for the message history that you get with `:Noice`
					view = "split",
					opts = { enter = true, format = "details" },
					filter = {
						any = {
							{ event = "notify" },
							{ error = true },
							{ warning = true },
							{ event = "msg_show", kind = { "" } },
							{ event = "lsp", kind = "message" },
						},
					},
				},
				last = {
					view = "notify",
					opts = { enter = true, format = "details" },
					filter = {
						any = {
							{ event = "notify" },
							{ error = true },
							{ warning = true },
							{ event = "msg_show", kind = { "" } },
							{ event = "lsp", kind = "message" },
						},
					},
					filter_opts = { count = 1 },
				},
				errors = {
					-- options for the message history that you get with `:Noice`
					view = "popup",
					opts = { enter = true, format = "details" },
					filter = { error = true },
					filter_opts = { reverse = true },
				},
				all = {
					-- options for the message history that you get with `:Noice`
					view = "split",
					opts = { enter = true, format = "details" },
					filter = {},
				},
			},
			cmdline = {
				enabled = true,
				view = "cmdline_popup",
				opts = {},
				---@type table<string, CmdlineFormat>
				format = {
					cmdline = { pattern = "^:", icon = "", lang = "vim" },
					search_down = { kind = "search", pattern = "^/", icon = " ", lang = "regex" },
					search_up = { kind = "search", pattern = "^%?", icon = " ", lang = "regex" },
					filter = { pattern = "^:%s*!", icon = "$", lang = "bash" },
					lua = { pattern = { "^:%s*lua%s+", "^:%s*lua%s*=%s*", "^:%s*=%s*" }, icon = "", lang = "lua" },
					help = { pattern = "^:%s*he?l?p?%s+", icon = "" },
					input = { view = "cmdline_input", icon = "󰥻 " }, -- Used by input()
				},
			},

			notify = {
				enabled = true,
				view = "notify",
			},
			lsp = {
				progress = {
					enabled = true,
					-- Lsp Progress is formatted using the builtins for lsp_progress. See config.format.builtin
					-- See the section on formatting for more details on how to customize.
					--- @type NoiceFormat|string
					format = "lsp_progress",
					--- @type NoiceFormat|string
					format_done = "lsp_progress_done",
					throttle = 1000 / 30, -- frequency to update lsp progress message
					view = "mini",
				},
				override = {
					-- override the default lsp markdown formatter with Noice
					["vim.lsp.util.convert_input_to_markdown_lines"] = true,
					-- override the lsp markdown formatter with Noice
					["vim.lsp.util.stylize_markdown"] = true,
					-- override cmp documentation with Noice (needs the other options to work)
					["cmp.entry.get_documentation"] = true,
				},
				hover = {
					enabled = true,
					silent = false, -- set to true to not show a message if hover is not available
					view = "hover", -- when nil, use defaults from documentation
					---@type NoiceViewOptions
					opts = {}, -- merged with defaults from documentation
				},
				signature = {
					enabled = false,
					auto_open = {
						--enabled = true,
						trigger = true, -- Automatically show signature help when typing a trigger character from the LSP
						luasnip = true, -- Will open signature help when jumping to Luasnip insert nodes
						throttle = 50, -- Debounce lsp signature help request by 50ms
					},
					view = nil, -- when nil, use defaults from documentation
					---@type NoiceViewOptions
					opts = {}, -- merged with defaults from documentation
				},
				message = {
					-- Messages shown by lsp servers
					enabled = true,
					view = "notify",
					opts = {},
				},
				-- defaults for hover and signature help
				documentation = {
					view = "hover",
					---@type NoiceViewOptions
					opts = {
						lang = "markdown",
						replace = true,
						render = "plain",
						format = { "{message}" },
						win_options = { concealcursor = "n", conceallevel = 3 },
					},
				},
			},

			popupmenu = {
				enabled = true, -- enables the Noice popupmenu UI
				backend = "nui", -- backend to use to show regular cmdline completions
				kind_icons = {}, -- set to `false` to disable icons
			},
			presets = {
				bottom_search = true, -- use a classic bottom cmdline for search
				command_palette = true, -- position the cmdline and popupmenu together
				lsp_doc_border = true,
			},
		},
		config = function(_, opts)
			if vim.o.filetype == "lazy" then
				vim.cmd([[messages clear]])
			end
			require("noice").setup(opts)
		end,
	},

	{
		"folke/snacks.nvim",
		opts = {
			animate = { enabled = true },
			indent = { enabled = true },
			input = { enabled = true },
			notifier = { enabled = true },
			quickfile = { enabled = true },
			scroll = { enabled = true },
			statuscolumn = { enabled = true },
			picker = { enabled = true },
		},
	},

	{
		"snacks.nvim",
		opts = {
			picker = {
				enabled = true,
			},
		},
	},

	{
		"snacks.nvim",
		opts = {
			dashboard = {
				preset = {
					header = dashboard_header,
					-- stylua: ignore
					keys = {
						{ icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
						{ icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
						{ icon = " ", key = "g", desc = "Find Text", action = ":lua Snacks.dashboard.pick('live_grep')",},
						{ icon = " ", key = "r", desc = "Recent Files", action = ":lua Snacks.dashboard.pick('oldfiles')",},
						{ icon = " ",key = "c",desc = "Config", action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})",},
						{ icon = " ", key = "s", desc = "Restore Session", section = "session" },
						{ icon = "󰒲 ",key = "L",desc = "Lazy",action = ":Lazy",enabled = package.loaded.lazy ~= nil,},
						{ icon = " ", key = "q", desc = "Quit", action = ":qa" },
					},
				},
			},
		},
	},

	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		opts_extend = { "spec" },
		opts = {
			preset = "helix",
			defaults = {},
			spec = {
				{
					mode = { "n", "v" },
					{ "<leader>b", group = "buffers" },
					{ "<leader>c", group = "code" },
					{ "<leader>f", group = "files" },
					{ "<leader>g", group = "git" },
					{ "<leader>h", group = "history", icon = { icon = " ", color = "cyan" } },
					{ "<leader>u", group = "ui", icon = { icon = "󰙵 ", color = "cyan" } },
					{ "<leader>s", group = "search" },
					{ "z", group = "fold" },
					{
						"<leader>w",
						group = "windows",
						proxy = "<c-w>",
						expand = function()
							return require("which-key.extras").expand.win()
						end,
					},
					-- better descriptions
					{ "gx", desc = "Open with system app" },
				},
			},
		},
	},
	{
		"MeanderingProgrammer/render-markdown.nvim",
		dependencies = { "nvim-treesitter/nvim-treesitter", "echasnovski/mini.nvim" }, -- if you use the mini.nvim suite
		---@module 'render-markdown'
		---@type render.md.UserConfig
		opts = {},
		config = function()
			require("render-markdown").setup({})
		end,
	},
	{
		"stevearc/oil.nvim",
		lazy = false,
		config = function()
			require("oil").setup({})
		end,
	},
	{
		"alex-popov-tech/store.nvim",
		dependencies = {
			"OXY2DEV/markview.nvim", -- optional, for pretty readme preview / help window
			"nvim-lua/plenary.nvim",
		},
		cmd = "Store",
		keys = {
			{ "<leader>p", "<cmd>Store<cr>", desc = "Open Plugin Store" },
		},
		opts = {
			-- optional configuration here
		},
	},
}
