local opt = vim.opt
local g = vim.g

opt.termguicolors = true -- True color support
-------------------------------------- globals -----------------------------------------
g.toggle_theme_icon = "   "
-------------------------------------- options ------------------------------------------
--statusline
opt.laststatus = 3
opt.showmode = false

--clipboard
opt.clipboard = "unnamedplus"
opt.cursorline = true
opt.cursorlineopt = "number"

-- Indenting
opt.expandtab = true
opt.shiftwidth = 4
opt.smartindent = true
opt.autoindent = true
opt.tabstop = 4
opt.softtabstop = 2

-- menu
opt.pumheight = 5
opt.wildmenu = true

opt.fillchars = {
	foldopen = "",
	foldclose = "",
	fold = " ",
	foldsep = " ",
	diff = "╱",
	eob = " ",
}
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = true

-- Numbers
opt.number = true
opt.relativenumber = true
opt.numberwidth = 2
opt.ruler = false

-- disable nvim intro
opt.shortmess:append("sI")

opt.signcolumn = "yes"
opt.splitbelow = true
opt.splitright = true
opt.timeoutlen = 400
opt.undofile = true

-- disable some default providers
g.loaded_node_provider = 0
g.loaded_python3_provider = 0
g.loaded_perl_provider = 0
g.loaded_ruby_provider = 0

opt.completeopt = "menuone,noselect"
