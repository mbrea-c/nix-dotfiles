{ ... }: {
  compose = fns: builtins.foldl' (acc: fn: acc fn) (x: x);
  attrsToList = attrs:
    builtins.attrNames
    (builtins.mapAttrs (key: value: { inherit key value; }) attrs);
}
