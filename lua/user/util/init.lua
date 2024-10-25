local M = {}

--- Return a list of files in the given absolute path
---@param path string
---@return string[]
M.ls = function(path)
  local contents = {}

  local handle, _ = vim.uv.fs_scandir(path)
  if handle then
    while true do
      local name, _ = vim.uv.fs_scandir_next(handle)
      if not name then
        break
      else
        table.insert(contents, name)
      end
    end
  end

  return contents
end

--- Combines 2 tables with a combination function on duplicated keys
--- indexed items are appanded
---
--- ```
--- >>> union_with({ 1,2,3, a = 1, b = 2 }, { 4,5,6, b = 3, c = 4 }, function(a, b) return a + b end)
--- { 1,2,3,4,5,6, a = 1, b = 5, c = 4 }
--- ```
--- @generic T
---@param f function<T, T>
---@param t1 table<any, T>
---@param t2 table<any, T>
---@return table<any, T>
M.union_with = function(f, t1, t2)
  if t1 == nil then
    return t2 or {}
  elseif t2 == nil then
    return t1
  end

  local t = t1
  local i = #t1

  for k, v in pairs(t2) do
    if type(k) == "number" then
      i = i + 1
      t[i] = v
    else
      if t1[k] ~= nil then
        t1[k] = f(t1[k], v)
      else
        t1[k] = v
      end
    end
  end
  return t
end

--- Combines 2 tables with a combination function on duplicated keys
--- indexed items are appanded
---
--- ```
--- >>> merge_recursive_with({ 1,2,3, a = 1, b = 2 }, { 4,5,6, b = 3, c = 4 }, function(a, b) return a + b end)
--- { 1,2,3,4,5,6, a = 1, b = 5, c = 4 }
--- ```
--- @generic T
---@param f function<T, T>
---@param t1 table<any, T>
---@param t2 table<any, T>
---@return table<any, T>
local function merge_recursive_with(f, t1, t2)
  if t1 == nil then
    return t2 or {}
  elseif t2 == nil then
    return t1
  end

  local t = t1
  local i = #t1

  for k, v in pairs(t2) do
    if type(k) == "number" then
      i = i + 1
      t[i] = v
    elseif t[k] ~= nil then
      trace(k)
      if type(t[k]) == 'table' and type(v) == 'table' then
        t[k] = merge_recursive_with(f, t[k], v)
      elseif type(t[k]) == 'table' then
        table.insert(t[k], v)
      elseif type(v) == 'table' then
        table.insert(v, t[k])
        t[k] = v
      else
        t[k] = f(t[k], v)
      end
    else
      t[k] = v
    end
  end

  return t
end

M.merge_recursive_with = merge_recursive_with

---Blend 2 hexadecimal colors by a value
---@param color1 string
---@param color2 string
---@param interpolation number
---@return string
M.blend = function(color1, color2, interpolation)
  local rgb1 = tonumber(color1:sub(2), 16)
  local r1 = bit.band(bit.rshift(rgb1, 16), 0xFF)
  local g1 = bit.band(bit.rshift(rgb1, 8), 0xFF)
  local b1 = bit.band(rgb1, 0xFF)
  local rgb2 = tonumber(color2:sub(2), 16)
  local r2 = bit.band(bit.rshift(rgb2, 16), 0xFF)
  local g2 = bit.band(bit.rshift(rgb2, 8), 0xFF)
  local b2 = bit.band(rgb2, 0xFF)
  local r = math.floor(r1 * (1 - interpolation) + r2 * interpolation)
  local g = math.floor(g1 * (1 - interpolation) + g2 * interpolation)
  local b = math.floor(b1 * (1 - interpolation) + b2 * interpolation)
  return string.format("#%02x%02x%02x", r, g, b)
end

return M
