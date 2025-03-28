{ lib, ... }: {
  compose = fns: lib.lists.foldr (fn: acc: (x: fn (acc x))) (x: x);
}
