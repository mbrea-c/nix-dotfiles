# { lib, ... }:
# systems: forSystem: builtins.foldl' lib.attrsets.recursiveUpdate { } (map forSystem systems)

{ lib, ... }:
systemConfigs:
builtins.foldl' lib.attrsets.recursiveUpdate { } (
  map (
    { systems, forSystem }: builtins.foldl' lib.attrsets.recursiveUpdate { } (map forSystem systems)
  ) systemConfigs
)
