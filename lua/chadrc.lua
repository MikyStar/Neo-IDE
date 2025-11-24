-- This file needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/ui/blob/v3.0/lua/nvconfig.lua
-- Please read that file to know all available options :(

---@type ChadrcConfig
local M = {}

--------------------------------------------------------------------

M.base46 = {
  theme = "radium",
}

--------------------------------------------------------------------

local handle = io.popen "pwd"
local pwd = handle:read()

local pwdLine = pwd
local spaceToFill = (54 - string.len(pwd))
for i = 0, spaceToFill do
  if i % 2 == 0 then
    pwdLine = pwdLine .. " "
  else
    pwdLine = " " .. pwdLine
  end
end

-- https://www.asciiart.eu/text-to-ascii-art -> ANSI Shadow

M.nvdash = {
  load_on_startup = true,

  header = {
    "                                                      ",
    " ███╗   ██╗███████╗ ██████╗       ██╗██████╗ ███████╗ ",
    " ████╗  ██║██╔════╝██╔═══██╗      ██║██╔══██╗██╔════╝ ",
    " ██╔██╗ ██║█████╗  ██║   ██║█████╗██║██║  ██║█████╗   ",
    " ██║╚██╗██║██╔══╝  ██║   ██║╚════╝██║██║  ██║██╔══╝   ",
    " ██║ ╚████║███████╗╚██████╔╝      ██║██████╔╝███████╗ ",
    " ╚═╝  ╚═══╝╚══════╝ ╚═════╝       ╚═╝╚═════╝ ╚══════╝ ",
    "                                                      ",
    pwdLine,
    "                                                      ",
    "                                                      ",
  },

  buttons = {
    { txt = "󰈚  Recent Files", keys = "fo", cmd = "Telescope oldfiles" },
    { txt = "  Find File", keys = "ff", cmd = "Telescope find_files" },
    { txt = "󰈭  Find Word", keys = "fw", cmd = "Telescope live_grep" },
    { txt = "  Git", keys = "gg", cmd = "LazyGit" },
    { txt = "  Bookmarks", keys = "ma", cmd = "Telescope marks" },
    { txt = "  Mappings", keys = "ch", cmd = "NvCheatsheet" },
  },
}

--------------------------------------------------------------------

M.ui = {
  cmp = {
    abbr_maxwidth = 60,
    -- for tailwind, css lsp etc
    format_colors = {
      lsp = true,
      icon = "󱓻"
    },
  },

  tabufline = {
    show_numbers = true,
  },

  telescope = { style = "bordered" },
}

--------------------------------------------------------------------

M.nvim_tree = {
  git = {
    enable = true,
  },

  filters = {
    git_ignored = false,
  },

  renderer = {
    highlight_git = true,
    icons = {
      show = {
        git = true,
      },
    },
  }
}

--------------------------------------------------------------------

M.mason = {
  ensure_installed = {
    -- lua stuff
    "lua-language-server",
    "stylua",

    -- c/cpp stuff
    "clangd",
    "clang-format",

    -- python
    "python-lsp-server",
    "pydocstring",
    "pylint",
    "pyright",

    -- web
    "css-lsp",
    "deno",
    "eslint-lsp",
    "eslint_d",
    "graphql-language-cli",
    "html-lsp",
    "prettier",
    "tailwindcss-language-server",
    "typescript-language-server",
    "js-debug-adapter",

    -- rust
    "rust-analyzer",
    "codelldb",

    "editorconfig-checker",
  },
}

--------------------------------------------------------------------

return M
