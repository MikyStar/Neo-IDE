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
  "ruff", -- Python linter/formatter
  "rust_analyzer",
  "js-debug-adapter",
  "codelldb",
  "marksman" -- md
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

lspconfig.tailwindcss.setup({
  filetypes = {
    'html',
    'css',
    'scss',
    'javascript',
    'javascriptreact',
    'typescript',
    'typescriptreact',
  },
  settings = {
    tailwindCSS = {
      experimental = {
        classRegex = {
          -- Match cx('classes') and cx("classes")
          { "cx\\(([^)]*)\\)", "[\"'`]([^\"'`]*)[\"'`]" },
          -- Also match cx`classes` (template literals)
          "cx`([^`]*)`",
        },
      },
    },
  },
})

-- Python
lspconfig.ruff.setup({
  on_attach = function(client, bufnr)
    -- Format on save
    vim.api.nvim_create_autocmd("BufWritePre", {
      buffer = bufnr,
      callback = function()
        vim.lsp.buf.format({ async = false })
      end,
    })
  end,
})

----------------------------------------

vim.lsp.enable(servers)

-- read :h vim.lsp.config for changing options of lsp servers
