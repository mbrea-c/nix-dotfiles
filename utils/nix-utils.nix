{ lib, ... }: {
  compose = fns: lib.lists.foldr (fn: acc: target: fn (acc target)) (x: x);
  attrsToList = attrs:
    builtins.attrValues
    (builtins.mapAttrs (key: value: { inherit key value; }) attrs);
}
