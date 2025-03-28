{ lib, ... }: {
  compose = fns:
    lib.lists.foldr (fn: acc: builtins.trace fn (x: fn (acc x))) (x: x);
}
