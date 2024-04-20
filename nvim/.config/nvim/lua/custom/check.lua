local checked_character = "x"

local checked_checkbox = "%[" .. checked_character .. "%]"
local unchecked_checkbox = "%[ %]"

local line_contains_unchecked = function(line)
  return line:find(unchecked_checkbox)
end

local line_contains_checked = function(line)
  return line:find(checked_checkbox)
end

local line_with_checkbox = function(line)
  -- return not line_contains_a_checked_checkbox(line) and not line_contains_an_unchecked_checkbox(line)
  return line:find("^%s*- " .. checked_checkbox)
      or line:find("^%s*- " .. unchecked_checkbox)
      or line:find("^%s*%d%. " .. checked_checkbox)
      or line:find("^%s*%d%. " .. unchecked_checkbox)
end


local checkbox = {
  check = function(line)
    return line:gsub(unchecked_checkbox, checked_checkbox, 1)
  end,

  uncheck = function(line)
    return line:gsub(checked_checkbox, unchecked_checkbox, 1)
  end,

  make_checkbox = function(line)
    if not line:match("^%s*-%s.*$") and not line:match("^%s*%d%s.*$") then
      -- "xxx" -> "- [ ] xxx"
      return line:gsub("(%S+)", "- [ ] %1", 1)
    else
      -- "- xxx" -> "- [ ] xxx", "3. xxx" -> "3. [ ] xxx"
      return line:gsub("(%s*- )(.*)", "%1[ ] %2", 1):gsub("(%s*%d%. )(.*)", "%1[ ] %2", 1)
    end
  end,
}

local M = {}

M.toggle = function()
  local bufnr = 0

  local start_line = nil
  local end_line = nil

  print("mode: ".. vim.api.nvim_get_mode().mode)


  local cursor = vim.api.nvim_win_get_cursor(0)
  if vim.api.nvim_get_mode().mode == "v" then
    start_line = vim.fn.getpos("'<")[2] - 1
    end_line = vim.fn.getpos("'>")[2]
    -- line1 = vim.api.nvim_buf_get_mark(0, "<")[1]
    -- line2 = vim.api.nvim_buf_get_mark(0, ">")[1]
  else
    start_line = cursor[1] - 1
    end_line = cursor[1]
  end

  local lines = vim.api.nvim_buf_get_lines(bufnr, start_line, end_line, false)
  for i, line in ipairs(lines) do
    -- If the line contains a checked checkbox then uncheck it.
    -- Otherwise, if it contains an unchecked checkbox, check it.
    local new_line = ""

    if not line_with_checkbox(line) then
      new_line = checkbox.make_checkbox(line)
    elseif line_contains_unchecked(line) then
      new_line = checkbox.check(line)
    elseif line_contains_checked(line) then
      new_line = checkbox.uncheck(line)
    end

    vim.api.nvim_buf_set_lines(bufnr, start_line + i - 1, start_line + i, false, { new_line })
  end

  vim.api.nvim_win_set_cursor(0, cursor)
end

vim.api.nvim_create_user_command("ToggleCheckbox", M.toggle, {})

vim.keymap.set("", "<leader>x", function() require('custom.check').toggle() end, { silent = true })

return M
