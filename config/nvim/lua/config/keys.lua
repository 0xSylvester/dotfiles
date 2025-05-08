local map = vim.keymap.set

-- Move Lines
map("n", "<A-j>", "<cmd>execute 'move .+' . v:count1<cr>==", { desc = "Move Down" })
map("n", "<A-k>", "<cmd>execute 'move .-' . (v:count1 + 1)<cr>==", { desc = "Move Up" })
map("i", "<A-j>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move Down" })
map("i", "<A-k>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move Up" })
map("v", "<A-j>", ":<C-u>execute \"'<,'>move '>+\" . v:count1<cr>gv=gv", { desc = "Move Down" })
map("v", "<A-k>", ":<C-u>execute \"'<,'>move '<-\" . (v:count1 + 1)<cr>gv=gv", { desc = "Move Up" })

-- stylua: ignore start

-- buffers
map("n", "<leader>bn", "<cmd> bnext <cr>", {desc = "Next buffer"})
map("n", "<leader>bp", "<cmd> bprevious <cr>", {desc = "Previous buffer"})
map("n", "<leader>bd", function() Snacks.bufdelete() end, { desc = "Delete currunt buffer" })
map("n", "<leader>bo", function() Snacks.picker.buffers() end, { desc = "Buffer picker"})

-- LSP
map("n", "<leader>ch", function() vim.lsp.buf.hover() end, { desc = "Hover"})
map("n", "<leader>ca", function() vim.lsp.buf.code_action() end, { desc = "Code Action"})
map("n", "<leader>cj", function() vim.lsp.buf.definition() end, { desc = "Go to definition"})
map("n", "<leader>cd", function() vim.lsp.buf.declaration() end, { desc = "Go to decleration"})
map("n", "<leader>cs", function() vim.lsp.buf.signature_help() end, { desc = "Signature Help"})
map("n", "<leader>cr", function() vim.lsp.buf.rename() end, { desc = "Rename"})
map("n", "<leader>cf", function() require("conform").format() end , {desc = "Format"})
-- LSP + Picker
map("n", "<leader>cpd", function() Snacks.picker.lsp_definitions() end, {desc = "Definitions"})
map("n", "<leader>cpD", function() Snacks.picker.lsp_declarations() end, {desc = "Declarations"})
map("n", "<leader>cpi", function() Snacks.picker.lsp_implementations() end, {desc = "Implementation"})
map("n", "<leader>cpr", function() Snacks.picker.lsp_references() end, {desc = "References" })
map("n", "<leader>cps", function() Snacks.picker.symbols() end, { desc = "Symbols"})

-- Git 
map("n", "gn", "<cmd>Gitsigns next_hunk<CR>", {desc = "Next hunk" })
map("n", "gN", "<cmd>Gitsigns prev_hunk<CR>", {desc = "Prev hunk" })
map("n", "<leader>gb", "<cmd>Gitsigns blame_line<CR>", {desc = "Blame line" })
map("n", "<leader>gd", "<cmd>Gitsigns toggle_deleted<CR>", {desc = "Toggle deleted" })
map("n", "<leader>gw", "<cmd>Gitsigns toggle_word_diff<CR>", {desc = "Toggle word diff" })
map("n", "<leader>gO", "<cmd>Gitsigns<CR>", {desc = "Git Options" })
map("n", "<leader>gl", "<cmd>Gitsigns toggle_current_line_blame<CR>", {desc = "toggle current hine blame" })
map("n", "<leader>go", function() Snacks.gitbrowse.open() end, {desc = "Open repo in browser"})

-- History
map("n", "<leader>hl", function() require("noice").cmd("last") end, { desc = "Last Message" })
map("n", "<leader>he", function() require("noice").cmd("errors") end, { desc = "Errors"})
map("n", "<leader>hc", function() Snacks.picker.command_history() end, { desc = "Command History"})
map("n", "<leader>hh", function() Snacks.picker.notifications() end, { desc = "Notification History" })

-- Search
map("n", "<leader>sl", function() Snacks.picker.lines() end, { desc = "Grep buffer lines" })
map({"n", "v"}, "<leader>sv", function() Snacks.picker.grep_word() end, { desc = "Grep visual" })
map("n", "<leader>sh", function() Snacks.picker.search_history() end, { desc = "Search history"})

-- Files 
map("n", "<leader>ff", function() Snacks.picker.files() end, { desc = "Files picker"})
map("n", "<leader>fe", function() Snacks.picker.explorer() end, { desc = "Explorer"})

-- UI
map("n", "<leader>uNo", "<cmd> Noice enable <cr>", { desc = "Enable Noice"})
map("n", "<leader>uNf", "<cmd> Noice disable <cr>", { desc = "Disable Noice"})
Snacks.toggle.line_number():map("<leader>ul")
Snacks.toggle.animate():map("<leader>ui")
Snacks.toggle.scroll():map("<leader>us")
Snacks.toggle.dim():map("<leader>ud")
Snacks.toggle.indent():map("<leader>u<tab>")
