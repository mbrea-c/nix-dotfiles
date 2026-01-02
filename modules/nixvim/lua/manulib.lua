local nix_config = require("nix-config")

local M = {};

function M.is_in(value, list)
  for _, val in ipairs(list) do
    if val == value then
      return true
    end
  end
  return false
end

function M.filtered_format(bufnr)
  local ignore_formatting = nix_config.ignored_servers -- ${nixToLua ignoredServers}
  vim.lsp.buf.format({
    filter = function(client)
      return not vim.tbl_contains(ignore_formatting, client.name)
    end,
    bufnr = bufnr,
    timeout_ms = 20000,
  })
end

return M
