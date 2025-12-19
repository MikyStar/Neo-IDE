require "nvchad.mappings"

local map = vim.keymap.set

--------------------------------------------------------------------
----------------------- Normal mode

-- Native NVIM API
map("n", "<C-e>", "5<C-e>", { desc = "Scroll down 5 lines" })
map("n", "<C-y>", "5<C-y>", { desc = "Scroll up 5 lines" })

map("n", "<S-Down>", ":m .+1<CR>==", { desc = "Move line down" })
map("n", "<S-Up>", ":m .-2<CR>==", { desc = "Move line up" })

map("n", "<leader>sv", "<cmd> vsplit <CR>", { desc = "Split vertical" })
map("n", "<leader>sh", "<cmd> split <CR>", { desc = "Split horizontal" })

map("n", "<Esc>", "<cmd> noh <CR>", { desc = "Clear highlights" })

map("n", "<C-s>", "<cmd> bufdo w <CR>", { desc = "Save all buffers" })

map("n", "<C-c>", "<cmd> %y+ <CR>", { desc = "Copy whole file" })

map("n", "<leader>b", "<cmd> enew <CR>", { desc = "New buffer" })

map("n", "<leader>n", "<cmd> set nu! <CR>", { desc = "Toggle line number" })
map("n", "<leader>rn", "<cmd> set rnu! <CR>", { desc = "Toggle relative number" })
map("n", "<C-z>", "")

map("n", "<C-h>", "<C-w>h", { desc = "Window left" })
map("n", "<C-l>", "<C-w>l", { desc = "Window right" })
map("n", "<C-j>", "<C-w>j", { desc = "Window down" })
map("n", "<C-k>", "<C-w>k", { desc = "Window up" })

-- Allow moving the cursor through wrapped lines with j, k, <Up> and <Down>
-- http://www.reddit.com/r/vim/comments/2k4cbr/problem_with_gj_and_gk/
-- empty mode is same as using <cmd> :map
-- also don't use g[j|k] when in operator pending mode, so it doesn't alter d, y or c behaviour
map("n", "j", 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', { desc = "Move down", expr = true })
map("n", "k", 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', { desc = "Move up", expr = true })
map("n", "<Up>", 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', { desc = "Move down", expr = true })
map("n", "<Down>", 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', { desc = "Move up", expr = true })

-- Nvim-window
map("n", "<leader>ww", "<cmd> lua require('nvim-window').pick()<CR>", { desc = "Pick window" })

-- Gitsigns
map("n", "<leader>gn", "<cmd> Gitsigns next_hunk <CR>", { desc = "Next git hunk" })
map("n", "<leader>gp", "<cmd> Gitsigns prev_hunk <CR>", { desc = "Previous git hunk" })
map("n", "<leader>gR", "<cmd> Gitsigns reset_hunk <CR>", { desc = "Reset git hunk" })
map("n", "<leader>gb", "<cmd> Gitsigns blame_line <CR>", { desc = "Blame git hunk" })

map("n", "<leader>ch", "<cmd> NvCheatsheet <CR>", { desc = "Mapping cheatsheet" })

map("n", "<leader>lb", function() vim.lsp.buf.format { async = true } end, { desc = "LSP formatting" })

-- LSP
map("n", "gD", function() vim.lsp.buf.declaration() end, { desc = "LSP declaration" })
map("n", "<leader>D", function() vim.lsp.buf.type_definition() end, { desc = "LSP definition type" })
map("n", "gd", function() vim.lsp.buf.definition() end, { desc = "LSP definition" })

map("n", "K", function() vim.lsp.buf.hover() end, { desc = "LSP hover" })
map("n", "gi", function() vim.lsp.buf.implementation() end, { desc = "LSP implementation" })
map("n", "<leader>ls", function() vim.lsp.buf.signature_help() end, { desc = "LSP signature help" })
map("n", "<leader>lr", function() vim.lsp.buf.rename() end, { desc = "LSP rename" })
map("n", "<leader>la", function() vim.lsp.buf.code_action() end, { desc = "LSP code action" })
map("n", "<leader>lf", function() vim.diagnostic.open_float { border = "rounded" } end, { desc = "Floating diagnostic" })

map("n", "<leader>lp", function() vim.diagnostic.goto_prev { float = { border = "rounded" } } end,
  { desc = "LSP goto previous" })
map("n", "<leader>ln", function() vim.diagnostic.goto_next { float = { border = "rounded" } } end,
  { desc = "LSP goto next" })
map("n", "<leader>q", function() vim.diagnostic.setloclist() end, { desc = "Diagnostic setloclist" })

-- Telescope
map("n", "<leader>ff", "<cmd> Telescope find_files follow=true hidden=true <CR>", { desc = "Find files" })
map("n", "<C-p>", "<cmd> Telescope find_files follow=true hidden=true <CR>", { desc = "Find files" })

map("n", "<leader>fw", "<cmd> Telescope live_grep <CR>", { desc = "Live grep" })
map("n", "<leader>fr", "<cmd> Telescope resume <CR>", { desc = "Resume last Telescope session" })

map("n", "<leader>fb", "<cmd> Telescope buffers <CR>", { desc = "Find buffers" })
map("n", "<leader>fo", "<cmd> Telescope oldfiles <CR>", { desc = "Find oldfiles" })

map("n", "<leader>fq", "<cmd> Telescope quickfix <CR>", { desc = "Quickfixes" })

map("n", "<leader>gc", "<cmd> Telescope git_commits <CR>", { desc = "Git commits" })
map("n", "<leader>gs", "<cmd> Telescope git_status <CR>", { desc = "Git status" })

map("n", "<leader>fm", "<cmd> Telescope marks <CR>", { desc = "Bookmarks" })

-- Outline
map("n", "<leader>oo", "<cmd> Outline <CR>", { desc = "File outline" })

-- Hop
map("x", "<leader><leader>w", "<cmd>HopWord<cr>", { noremap = true, silent = true })
map("n", "<leader><leader>w",
  function() require('hop').hint_words({ direction = require('hop.hint').HintDirection.AFTER_CURSOR }) end,
  { noremap = true, silent = true, desc = 'Hop Word' })
map("n", "<leader><leader>b",
  function() require('hop').hint_words({ direction = require('hop.hint').HintDirection.BEFORE_CURSOR }) end,
  { noremap = true, silent = true, desc = 'Hop Before' })

map("n", "<leader><leader>W", "<cmd>HopWordMW<cr>", { noremap = true, silent = true }) -- multiwindow

map("n", "<leader><leader>e",
  "<cmd>lua require'hop'.hint_words({ hint_position = require'hop.hint'.HintPosition.END })<cr>",
  { noremap = true, silent = true }) -- multiwindow

map("n", "<leader><leader>l", "<cmd>HopLineStart<cr>", { noremap = true, silent = true })
map("x", "<leader><leader>l", "<cmd>HopLineStart<cr>", { noremap = true, silent = true })

map("n", "<leader><leader>s", "<cmd>lua require'hop'.hint_patterns()<cr>", { noremap = true, silent = true })

map("n", "<leader><leader>(", "<cmd>lua require'hop'.hint_patterns({}, '(')<cr>", { noremap = true, silent = true })
map("n", "<leader><leader>)", "<cmd>lua require'hop'.hint_patterns({}, ')')<cr>", { noremap = true, silent = true })

map("n", "<leader><leader>{", "<cmd>lua require'hop'.hint_patterns({}, '{')<cr>", { noremap = true, silent = true })
map("n", "<leader><leader>}", "<cmd>lua require'hop'.hint_patterns({}, '}')<cr>", { noremap = true, silent = true })

map("n", "<leader><leader>[", "<cmd>lua require'hop'.hint_patterns({}, '[[[]]')<cr>", { noremap = true, silent = true })
map("n", "<leader><leader>]", "<cmd>lua require'hop'.hint_patterns({}, ']')<cr>", { noremap = true, silent = true })

map("n", "<leader><leader><", "<cmd>lua require'hop'.hint_patterns({}, '<')<cr>", { noremap = true, silent = true })
map("n", "<leader><leader>>", "<cmd>lua require'hop'.hint_patterns({}, '>')<cr>", { noremap = true, silent = true })

map("n", "<leader><leader>;", "<cmd>lua require'hop'.hint_patterns({}, ';')<cr>", { noremap = true, silent = true })

map("", "f",
  "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, current_line_only = true })<cr>",
  { noremap = true, silent = true }
)
map("", "F",
  "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, current_line_only = true })<cr>",
  { noremap = true, silent = true }
)

map("", "t",
  "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, current_line_only = true, hint_offset = -1 })<cr>",
  { noremap = true, silent = true }
)
map("", "T",
  "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, current_line_only = true, hint_offset = 1 })<cr>",
  { noremap = true, silent = true }
)

-- DAP (Debug Adapter Protocol)
local dap = require("dap")
local dapui = require("dapui")

map("n", "<leader>dc", dap.continue, { desc = "Debug: Start/Continue" })
map("n", "<leader>dC", dap.continue, { desc = "Debug: Disconnect" })
map("n", "<leader>dsO", dap.step_over, { desc = "Debug: Step Over", noremap = true })
map("n", "<leader>dsi", dap.step_into, { desc = "Debug: Step Into", noremap = true })
map("n", "<leader>dso", dap.step_out, { desc = "Debug: Step Out", noremap = true })
map("n", "<leader>db", dap.toggle_breakpoint, { desc = "Debug: Toggle Breakpoint" })
map("n", "<leader>dB", function() dap.set_breakpoint(vim.fn.input("Breakpoint condition: ")) end,
  { desc = "Debug: Set Conditional Breakpoint" })
map("n", "<leader>dr", dap.repl.open, { desc = "Debug: Open REPL" })
map("n", "<leader>dl", dap.run_last, { desc = "Debug: Run Last" })
map("n", "<leader>du", dapui.toggle, { desc = "Debug: Toggle UI" })
map("n", "<leader>di", function() require('dap.ui.widgets').hover() end, { desc = "Debug: Variable simple info" })
map("n", "<leader>dh", function()
  local word = vim.fn.expand("<cword>")
  dapui.eval(word, {
    context = "hover",
    width = 70,
    height = 15,
    enter = true
  })
end, { desc = "Debug: Extened variable hover" })

--------------------------------------------------------------------
----------------------- Insert mode

-- go to  beginning and end
map("i", "<C-b>", "<ESC>^i", { desc = "Beginning of line" })
map("i", "<C-e>", "<End>", { desc = "End of line" })

-- navigate within insert mode
map("i", "<C-h>", "<Left>", { desc = "Move left" })
map("i", "<C-l>", "<Right>", { desc = "Move right" })
map("i", "<C-j>", "<Down>", { desc = "Move down" })
map("i", "<C-k>", "<Up>", { desc = "Move up" })

--------------------------------------------------------------------
----------------------- Visual mode

map("v", "<Up>", 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', { desc = "Move up", expr = true })
map("v", "<Down>", 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', { desc = "Move down", expr = true })

map("v", "<", "<gv", { desc = "Unindent line" })
map("v", ">", ">gv", { desc = "Indent line" })

map("v", "<C-z>", "")

map("v", "<S-Down>", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
map("v", "<S-Up>", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })

--------------------------------------------------------------------
----------------------- Other mode

-- map("", "", "", { desc = "" }) TODO add more here
