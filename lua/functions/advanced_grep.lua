local M = {}

----------------------------------------

--- Will have multiple prompts to provide paths where to search including regex
--- but also an optional regex for the file type before calling Telescope's live grep
function M.advanced_grep()
  local search_dirs = {}

  local function prompt_for_path()
    Snacks.input({
      prompt = string.format("Path %d (empty to finish): ", #search_dirs + 1),
      default = #search_dirs == 0 and vim.fn.getcwd() or "",
      completion = "dir",
    }, function(paths)
      -- Empty input - finish collecting paths
      if not paths or paths == "" then
        if #search_dirs == 0 then
          vim.notify("No paths provided", vim.log.levels.WARN)
          return
        end

        -- Ask for file pattern
        Snacks.input({
          prompt = "File pattern (e.g. *.lua, **/*.ts): ",
          default = "",
        }, function(pattern)
          local opts = {
            search_dirs = search_dirs
          }

          if pattern and pattern ~= "" then
            opts.glob_pattern = pattern
          end

          require('telescope.builtin').live_grep(opts)
        end)
        return
      end

      -- Process the path(s)
      local path_list = {}

      if paths:match("{.*}") then
        table.insert(path_list, paths)
      else
        for path in string.gmatch(paths, "[^,]+") do
          table.insert(path_list, path)
        end
      end

      for _, path in ipairs(path_list) do
        path = vim.trim(path)
        if path ~= "" then
          path = path:gsub("^~", vim.env.HOME)

          local brace_content = path:match("{([^}]+)}")

          if brace_content then
            local base_path = path:match("^(.-)/[*{]")
            base_path = base_path:gsub("/%*+$", ""):gsub("%*+", "")

            for dir_name in string.gmatch(brace_content, "[^,]+") do
              dir_name = vim.trim(dir_name)

              local cmd = string.format('find "%s" -type d -name "%s" 2>/dev/null', base_path, dir_name)

              local handle = io.popen(cmd)
              if handle then
                for line in handle:lines() do
                  line = vim.trim(line)
                  if line ~= "" then
                    table.insert(search_dirs, line)
                  end
                end
                handle:close()
              end
            end
          else
            if vim.fn.isdirectory(path) == 1 then
              table.insert(search_dirs, path)
            end
          end
        end
      end

      -- Ask for another path
      prompt_for_path()
    end)
  end

  prompt_for_path()
end

----------------------------------------

return M
