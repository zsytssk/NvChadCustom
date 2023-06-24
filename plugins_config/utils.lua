local Path = require "plenary.path"
local sessions = require "sessions"
local M = {}

M.sessions_path = vim.fn.stdpath "data" .. "/sessions"

M.scan_dir = function(directory)
  local i, t, popen = 0, {}, io.popen
  local pfile = popen('ls -a "' .. directory .. '"')

  if pfile == nil then
    return nil
  end

  for filename in pfile:lines() do
    i = i + 1
    t[i] = filename
  end

  pfile:close()
  return t
end

M.get_current_cwd = function()
  return vim.fn.getcwd()
end

M.get_cwd_workspaces_config = function()
  local workspaces = require "workspaces"
  local workspaces_config = workspaces.get()

  for _, v in pairs(workspaces_config) do
    if M.path_is_same(v.path, M.get_current_cwd() .. "/") then
      return v
    end
  end
end

M.get_cwd_session_path = function()
  local cur_config = M.get_cwd_workspaces_config()
  if cur_config then
    return M.sessions_path .. "/" .. cur_config.name .. ".session"
  end
end

M.save_cur_session = function()
  local cur_config = M.get_cwd_workspaces_config()
  if cur_config == nil then
    return false
  end
  local has_session = M.has_session(cur_config.name)
  if has_session then
    return false
  end
  local session_path = M.get_cwd_session_path()
  sessions.save(session_path)
  return true
end

M.get_sessions_list = function()
  local directory = vim.fn.stdpath "data" .. "/sessions"
  local list = M.scan_dir(directory)
  return list
end

M.has_session = function(name)
  local list = M.get_sessions_list()
  if list == nil then
    return false
  end
  for _, v in pairs(list) do
    if v == name .. ".session" then
      return true
    end
  end
  return false
end

M.path_is_same = function(path1, path2)
  if path1 == nil or path2 == nil then
    return false
  end
  local p1 = Path.new(path1):absolute()
  local p2 = Path.new(path2):absolute()

  return p1 == p2
end

return M
