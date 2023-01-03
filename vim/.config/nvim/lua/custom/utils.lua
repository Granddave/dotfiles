local M = {}

P = function(v)
  print(vim.inspect(v))
  return v
end

if pcall(require, "plenary") then
  RELOAD = require("plenary.reload").reload_module

  R = function(name)
    RELOAD(name)
    return require(name)
  end
end

-- Check if modules are available
-- Pass either a string or a table of strings
HAS = function(arg)
  if type(arg) == "table" then
    for _, module in pairs(arg) do
      if not HAS(module) then
        return false
      end
    end
    return true
  elseif type(arg) == "string" then
    return pcall(require, arg)
  end
  error("Invalid argument with type=" .. type(arg))
end

M.table_keys = function(tab)
  local keys = {}
  for k, _ in pairs(tab) do
    table.insert(keys, k)
  end
  return keys
end

M.clean_trailing_spaces = function()
  local old_cursor = vim.api.nvim_win_get_cursor(0)
  local old_query = vim.fn.getreg("/")
  vim.cmd([[%s/\s\+$//e]])
  vim.api.nvim_win_set_cursor(0, old_cursor)
  vim.fn.setreg("/", old_query)
end

M.get_module_name = function(module_path)
  local module_name;

  module_name = module_path:gsub("%.lua", "")
  module_name = module_name:gsub("%/", ".")
  module_name = module_name:gsub("%.init", "")

  return module_name
end

M.reload_lua_file = function(filepath)
  local string_pos = nil
  for _, path in pairs({ ".config/nvim/lua/", ".config/nvim/after/" }) do
    local _, j = string.find(filepath, path)
    if j ~= nil then
      string_pos = j
      break
    end
  end
  if not string_pos then
    print("Reload failed: Not a lua config file")
    return
  end
  local module_filepath = string.sub(filepath, string_pos + 1)
  local module_name = M.get_module_name(module_filepath)
  R(module_name)
end

M.reload_current_lua_file = function()
  M.reload_lua_file(vim.api.nvim_buf_get_name(0))
end

M.get_branch_name = function()
  local is_inside_git_repo = vim.fn.system("git rev-parse --is-inside-work-tree 2> /dev/null") ~= ""
  if not is_inside_git_repo then
    return ""
  end
  return vim.fn.system("git branch --show-current"):gsub("\n", "")
end

M.find_jira_key = function(str)
  return string.match(str, [[%a+-%d+]]) or ""
end

M.bytes_in_buffer = function(bufnr)
  local num_lines = vim.api.nvim_buf_line_count(bufnr)
  return vim.fn.line2byte(num_lines + 1)
end

M.set_private_mode = function()
  vim.o.shada = ""
  vim.o.swapfile = false
  vim.o.undofile = false
  vim.o.backup = false
  vim.o.writebackup = false
  vim.o.shelltemp = false
  vim.o.history = 0
  vim.o.modeline = false
  vim.o.secure = true
end

return M
