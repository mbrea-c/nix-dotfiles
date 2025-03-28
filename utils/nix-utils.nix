{ lib, ... }: {
  compose = fns:
    lib.lists.foldr (fn: acc: (target: builtins.trace fn (fn (acc target))))
    (x: x);
  attrsToList = attrs:
    lib.mapAttrsToList (key: value: { inherit key value; }) attrs;
}
