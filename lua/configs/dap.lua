local M = {}

function M.setup()
  local dap = require("dap")
  local dapui = require("dapui")

  -- Setup DAP UI
  dapui.setup()

  -- Setup virtual text
  require("nvim-dap-virtual-text").setup()

  -- Mason DAP setup for automatic adapter installation
  require("mason-nvim-dap").setup({
    ensure_installed = { "node2", "codelldb" },
    automatic_installation = true,
    handlers = {},
  })

  -- Auto-open/close DAP UI
  dap.listeners.after.event_initialized["dapui_config"] = function()
    dapui.open()
  end
  dap.listeners.before.event_terminated["dapui_config"] = function()
    dapui.close()
  end
  dap.listeners.before.event_exited["dapui_config"] = function()
    dapui.close()
  end

  vim.fn.sign_define('DapBreakpoint', { text = '🔵', texthl = '', linehl = '', numhl = '' })

  -------------------------------------

  -- Node.js/TypeScript configuration
  dap.adapters["pwa-node"] = {
    type = "server",
    host = "localhost",
    port = "${port}",
    executable = {
      command = "node",
      args = {
        vim.fn.stdpath("data") .. "/mason/packages/js-debug-adapter/js-debug/src/dapDebugServer.js",
        "${port}",
      },
    },
  }

  dap.configurations.typescript = {
    {
      type = "pwa-node",
      request = "launch",
      name = "Launch file",
      program = "${file}",
      cwd = "${workspaceFolder}",
      runtimeExecutable = "ts-node",
    },
    {
      type = "pwa-node",
      request = "attach",
      name = "Attach",
      processId = require("dap.utils").pick_process,
      cwd = "${workspaceFolder}",
    },
  }

  dap.configurations.javascript = dap.configurations.typescript

  -- Rust configuration using codelldb
  dap.adapters.codelldb = {
    type = "server",
    port = "${port}",
    executable = {
      command = vim.fn.stdpath("data") .. "/mason/bin/codelldb",
      args = { "--port", "${port}" },
    },
  }

  dap.configurations.rust = {
    {
      name = "Launch file",
      type = "codelldb",
      request = "launch",
      program = function()
        local program = vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/target/debug/", "file")
        local args_string = vim.fn.input("Arguments: ")

        vim.g.dap_last_args = vim.split(args_string, " ")
        return program
      end,
      cwd = "${workspaceFolder}",
      stopOnEntry = false,
      args = function()
        return vim.g.dap_last_args or {}
      end,
    },
    {
      name = "Attach to process",
      type = "codelldb",
      request = "attach",
      pid = require("dap.utils").pick_process,
      args = {},
    },
  }
end

return M
