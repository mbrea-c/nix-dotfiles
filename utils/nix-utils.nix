{ lib, ... }: {
  compose = fns: target:
    (lib.lists.foldr (fn: acc: target: fn (acc target)) (x: x) fns) target;
  attrsToList = attrs:
    lib.mapAttrsToList (key: value: { inherit key value; }) attrs;
}
