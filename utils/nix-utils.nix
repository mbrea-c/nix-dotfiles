{ ... }: {
  compose = fns: target:
    builtins.foldl' (acc: fn: target: acc (fn target)) (x: x) target;
  attrsToList = attrs:
    builtins.attrNames
    (builtins.mapAttrs (key: value: { inherit key value; }) attrs);
}
