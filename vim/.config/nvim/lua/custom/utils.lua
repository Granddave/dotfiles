M = {}

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
  local _, j = string.find(filepath, ".config/nvim/lua/")
  if j == nil then
    print("Reload failed: Not a lua config file")
    return
  end
  local module_filepath = string.sub(filepath, j + 1)
  local module_name = M.get_module_name(module_filepath)
  R(module_name)
  print("Reloaded " .. module_name)
end

M.reload_current_lua_file = function()
  M.reload_lua_file(vim.api.nvim_buf_get_name(0))
end

M.get_branch_name = function()
  local git = vim.fn.system("git rev-parse --is-inside-work-tree 2> /dev/null")
  if git ~= "" then
    local branch = vim.fn.system("git branch --show-current")
    return branch:gsub("\n", "")
  end

  return ""
end

M.find_jira_key_from_string = function(str)
  local match = string.match(str, [[%a+-%d+]])
  if match == nil then
    return ""
  end
  return match
end

return M
