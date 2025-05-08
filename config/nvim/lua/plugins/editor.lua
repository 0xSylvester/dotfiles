return {
	{
		"MagicDuck/grug-far.nvim",
		opts = { headerMaxWidth = 80 },
		cmd = "GrugFar",
		keys = {
			{
				"<leader>sr",
				function()
					local grug = require("grug-far")
					local ext = vim.bo.buftype == "" and vim.fn.expand("%:e")
					grug.open({
						transient = true,
						prefills = {
							filesFilter = ext and ext ~= "" and "*." .. ext or nil,
						},
					})
				end,
				mode = { "n", "v" },
				desc = "Search and Replace",
			},
		},
	},

	{
		"folke/flash.nvim",
		event = "VeryLazy",
		vscode = true,
		---@type Flash.Config
		opts = {},
	    -- stylua: ignore
	    keys = {
	      { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
	      { "S", mode = { "n", "o", "x" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
	      { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
	      { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
	      { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
	    },
	},

	{
		event = { "BufReadPre", "BufNewFile" },
		"stevearc/conform.nvim",

		config = function()
			local conform = require("conform")
			conform.setup({
				formatters_by_ft = {
					lua = { "stylua" },
					go = { "gofmt" },
					sh = { "shfmt" },
					c = { "clang-format" },
					cpp = { "clang-format" },
					json = { "cfn-lint" },
				},
			})
			vim.api.nvim_create_autocmd({ "BufWritePre", "BufRead" }, {
				pattern = "*",
				callback = function(args)
					conform.format({ bufnr = args.buf })
				end,
			})
		end,
	},
}
