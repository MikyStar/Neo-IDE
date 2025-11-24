require("nvchad.configs.lspconfig").defaults()

local on_attach = require("nvchad.configs.lspconfig").on_attach
local on_init = require("nvchad.configs.lspconfig").on_init
local capabilities = require("nvchad.configs.lspconfig").capabilities

local lspconfig = require("lspconfig")

----------------------------------------

local servers = {
  "html",
  "cssls",
  "tsserver",
  "clangd",
  "tailwindcss",
  "eslint",
  "pyright",
  "rust_analyzer",
  "js-debug-adapter",
  "codelldb"
}

----------------------------------------

-- TypeScript/JavaScript
lspconfig.ts_ls.setup({
  on_attach = on_attach,
  on_init = on_init,
  capabilities = capabilities,
})

-- ESLint
lspconfig.eslint.setup({
  on_attach = on_attach,
  on_init = on_init,
  capabilities = capabilities,
})

----------------------------------------

vim.lsp.enable(servers)

-- read :h vim.lsp.config for changing options of lsp servers
