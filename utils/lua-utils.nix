{ ... }: rec {
  lua = l: { __raw = l; };
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
        function(bufnr)
          local ignore_formatting = ${nixToLua ignoredServers}
          vim.lsp.buf.format({
            filter = function(client)
              return ~vim.tbl_contains(client.name, ignore_formatting)
            end,
            bufnr = bufnr,
            timeout_ms = 20000,
          })
        end
      '';
  };
}
