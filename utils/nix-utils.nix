{ ... }: { compose = fns: builtins.foldl' (acc: fn: acc fn) (x: x); }
