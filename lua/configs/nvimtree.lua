local M = {}


M = {
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
    full_name = true,
  },

  view = {
    preserve_window_proportions = true,
  }
}

return M
