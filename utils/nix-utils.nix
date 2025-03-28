{ ... }: { compose = fns: builtins.foldl' (acc: fn: (x: acc (fn x))) (x: x); }
