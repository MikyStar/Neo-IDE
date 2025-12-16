return {
  {
    "lewis6991/gitsigns.nvim",
    opts = function(_, opts)
      -- Overloading NvChad default config

      opts.current_line_blame = true

      return opts
    end,
  },

  {
    "nvim-tree/nvim-tree.lua",
    opts = require('configs.nvimtree')
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      -- Overloading NvChad default config

      opts.ensure_installed = {
        "vim",
        "lua",

        "rust",
        "typescript",
        "javascript",
        "tsx",
        "json",
        "html",
        "css",
        "python",
        "go",
        "markdown",
      }

      return opts
    end,
  },

  {
    "stevearc/conform.nvim",
    event = 'BufWritePre', -- format on save
    opts = require "configs.conform",
  },

  -- These are some examples, uncomment them if you want to see them work!
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },

  {
    "smoka7/hop.nvim",
    lazy = false,
    config = function()
      require('hop').setup()
    end,
  },

  {
    'MeanderingProgrammer/render-markdown.nvim',
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
      'nvim-tree/nvim-web-devicons'
    },
    lazy = false,
    config = function()
      vim.api.nvim_set_hl(0, "MdBlue", { fg = "#61AFEF", bg = "#152430" })
      vim.api.nvim_set_hl(0, "MdCyan", { fg = "#56B6C2", bg = "#142b2e" })
      vim.api.nvim_set_hl(0, "MdViolet", { fg = "#C678DD", bg = "#332038" })
      vim.api.nvim_set_hl(0, "MdYellow", { fg = "#ffdc5e", bg = "#362e14" })
      vim.api.nvim_set_hl(0, "MdRed", { fg = "#e47093", bg = "#30171f" })

      ---@module 'render-markdown'
      ---@type render.md.UserConfig
      local settings = {


        heading = {
          border = true,
          -- From https://www.nerdfonts.com/cheat-sheet
          icons = {
            "󰼏 ",
            "󰼐 ",
            "󰼑 ",
            "󰼒 ",
            "󰼓 ",
            "󰼔 ",
          },
          backgrounds = {
            "MdBlue",
            "MdCyan",
            "MdViolet",
            "MdYellow",
            "MdRed",
          },
          foregrounds = {
            "MdBlue",
            "MdCyan",
            "MdViolet",
            "MdYellow",
            "MdRed",
          }
        }
      }

      require('render-markdown').setup(settings)
    end,
  },

  {
    "hedyhli/outline.nvim",
    lazy = false,
    config = function()
      require("outline").setup {
        show_guides = true,
        show_numbers = true,
        show_relative_numbers = true,
      }
    end,
  },

  {
    "roobert/tailwindcss-colorizer-cmp.nvim",
    lazy = false,
    config = function()
      require("tailwindcss-colorizer-cmp").setup {
        color_square_width = 2,
      }
      require("cmp").setup {
        formatting = { format = require("tailwindcss-colorizer-cmp").formatter },
      }
    end,
  },

  {
    "kdheepak/lazygit.nvim",
    cmd = {
      "LazyGit",
      "LazyGitConfig",
      "LazyGitCurrentFile",
      "LazyGitFilter",
      "LazyGitFilterCurrentFile",
    },
    -- optional for floating window border decoration
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    -- setting the keybinding for LazyGit with 'keys' is recommended in
    -- order to load the plugin when the command is run for the first time
    keys = {
      { "<leader>gg", "<cmd>LazyGit<cr>", desc = "LazyGit" },
    },
  },

  {
    "tzachar/local-highlight.nvim",
    lazy = false,
    config = function()
      require("local-highlight").setup {
        file_types = nil,
      }
    end,
  },

  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
      bigfile = { enabled = true },
      -- dashboard = { enabled = true },
      explorer = { enabled = true },
      indent = { enabled = true },
      input = { enabled = true },
      picker = { enabledu = true },
      notifier = { enabled = true },
      quickfile = { enabled = true },
      scope = { enabled = true },
      scroll = { enabled = true },
      statuscolumn = { enabled = true },
      words = { enabled = true },
    },
    keys = {
      { "<leader>sn", function() Snacks.picker.notifications() end,   desc = "Notification History" },
      { "<leader>:",  function() Snacks.picker.command_history() end, desc = "Command history" },
      { "<leader>sd", function() Snacks.picker.diagnostics() end,     desc = "Diagnostics" },
      { "<leader>su", function() Snacks.picker.undo() end,            desc = "Undo history" },
      { "<leader>sm", function() Snacks.picker.marks() end,           desc = "Marks" },
      { "<leader>sz", function() Snacks.zen() end,                    desc = "Zen/Focus buffer" },
    },
  },

  {
    "lukas-reineke/indent-blankline.nvim",
    lazy = false,
    main = "ibl",

    config = function()
      local highlight = {
        "RainbowCyan",
        "RainbowBlue",
        "RainbowViolet",
        "RainbowYellow",
        "RainbowRed",
      }

      local hooks = require "ibl.hooks"
      -- create the highlight groups in the highlight setup hook, so they are reset
      -- every time the colorscheme changes
      hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
        vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#61AFEF" })
        vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#56B6C2" })
        vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#C678DD" })
        vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#ffdc5e" })
        vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#e47093" })
      end)

      require("ibl").setup { indent = { highlight = highlight } }
    end,

    opts = {},
  },

  {
    "HiPhish/rainbow-delimiters.nvim",
    event = "BufReadPre",
    config = function()
      local rainbow_delimiters = require("rainbow-delimiters")

      vim.g.rainbow_delimiters = {
        strategy = {
          [''] = rainbow_delimiters.strategy['global'],
        },
        query = {
          [""] = "rainbow-delimiters",
        },
        highlight = {
          "RainbowDelimiterBlue",
          "RainbowDelimiterViolet",
          "RainbowDelimiterYellow",
          "RainbowDelimiterGreen",
          "RainbowDelimiterOrange",
          "RainbowDelimiterRed",
          "RainbowDelimiterCyan",
        },
      }
    end,
  },

  {
    "yorickpeterse/nvim-window",
    lazy = false,
    config = function()
      require("nvim-window").setup {
        hint_hl = "Bold",
        border = "single",
      }
    end,
  },

  {
    "miversen33/sunglasses.nvim",
    -- lazy = false,
    config = function()
      require("sunglasses").setup {
        file_type = "SHADE",
        filter_percent = 0.45,
      }
    end,
    event = "UIEnter",
  },

  {
    "windwp/nvim-ts-autotag",
    lazy = false,
    config = function()
      require("nvim-ts-autotag").setup()
    end,
  },

  {
    "sphamba/smear-cursor.nvim",
    lazy = false,

    opts = {
      stiffness = 0.8,
      trailing_stiffness = 0.6,
      stiffness_insert_mode = 0.7,
      trailing_stiffness_insert_mode = 0.7,
      damping = 0.95,
      damping_insert_mode = 0.95,
      distance_stop_animating = 0.5,
    },
  },

  {
    'numToStr/Comment.nvim',
    opts = {
      opleader = {
        line = '<leader>/',
        block = '<leader><leader>/',
      }
    }
  },

  {
    "mfussenegger/nvim-dap",
    dependencies = {
      -- UI improvements
      "rcarriga/nvim-dap-ui",
      "nvim-neotest/nvim-nio",

      -- Virtual text showing variable values
      "theHamsta/nvim-dap-virtual-text",

      -- Mason integration for easy adapter installation
      "jay-babu/mason-nvim-dap.nvim",
    },
    config = function()
      require "configs.dap".setup()
    end,
  },
}
