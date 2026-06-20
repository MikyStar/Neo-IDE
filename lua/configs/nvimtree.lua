local M = {}


M = {
  sort = {
    sorter = function(nodes)
      table.sort(nodes, function(a, b)
        -- folders first
        if a.type ~= b.type then
          return a.type == "directory"
        end

        -- natural alphanumeric sort
        local function to_natural(s)
          return (s:lower():gsub("(%d+)", function(n)
            return ("%010d"):format(tonumber(n))
          end))
        end

        return to_natural(a.name) < to_natural(b.name)
      end)
    end,
  },

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
