{ ... }: rec {
  nixToLua = with builtins;
    x:
    if isString x then
      ''"${x}"''
    else if isInt x then
      toString x
    else if isBool x then
      (if x then "true" else "false")
    else if isList x then
      (if length x == 0 then
        "{}"
      else
        let x' = (map nixToLua x);
        in "{${foldl' (acc: elem: "${acc}, ${elem}") (head x') (tail x')}}")
    else
      trace "Unrecognized type in transpilation to Lua: ${toString x}" "";

  fns = {
    is_in = # lua
      ''
        function(value, list)
          for _, val in ipairs(list) do
            if val == value then
              return true
            end
          end
          return false
        end
      '';
    lspFormatFiltered = ignoredServers: # lua
      ''
        local function lsp_formatting(bufnr)
          local ignore_formatting = ${nixToLua ignoredServers}
          vim.lsp.buf.format({
            filter = function(clients)
              return vim.tbl_filter(function(client)
                return is_in(client, ignore_formatting)
              end, clients)
            end,
            bufnr = bufnr,
            timeout_ms = 10000,
          })
        end
      '';
  };
}
