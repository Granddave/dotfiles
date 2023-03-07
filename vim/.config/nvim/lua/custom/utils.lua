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
  return string.match(str, [[%a[%a%d]+-%d+]]) or ""
end

M.bytes_in_buffer = function(bufnr)
  local num_lines = vim.api.nvim_buf_line_count(bufnr)
  return vim.fn.line2byte(num_lines + 1)
end

M.open_url = function(url)
  vim.loop.spawn("xdg-open", { args = { url } })
end

M.browse_jira_issue = function(jira_key)
  local hostname = M.parse_config().jira_server_host
  if hostname == nil then
    error("Failed to load hostname for Jira server")
  end
  local url = "https://" .. hostname .. "/browse/" .. jira_key
  M.open_url(url)
end

M.match_regex_under_cursor = function(pattern)
  local line = vim.api.nvim_get_current_line()
  local cursor = vim.api.nvim_win_get_cursor(0)

  local start_pos = 0
  local end_pos = 0
  while true do
    start_pos, end_pos = line:find(pattern, start_pos + 1)
    if not start_pos then
      -- No more matches
      break
    end
    if cursor[2] + 1 >= start_pos and cursor[2] < end_pos then
      return line:sub(start_pos, end_pos)
    end
  end
end

M.open_jira_issue_under_cursor = function()
  local jira_key_pattern = "%a[%a%d]+-%d"
  -- wrap with word boundary matching as well
  local full_pattern = "%f[%w_]" .. jira_key_pattern .. "+%f[^%w_]"
  local jira_key = M.match_regex_under_cursor(full_pattern)
  if jira_key then
    M.browse_jira_issue(jira_key)
  end
end

M.parse_config = function()
  local filepath = "~/.config/nvim.json"
  local file = io.open(filepath, "r")
  if file == nil then
    error("Failed to open file: " .. filepath)
    return
  end
  local json_string = file:read("*a") -- Read the entire file
  file:close()
  local loaded_table = vim.fn.json_decode(json_string)
  if loaded_table == nil then
    error("Failed to parse json: " .. json_string)
    return
  end
  return loaded_table
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
