{ lib, ... }:
systems: forSystem:
builtins.foldl' lib.attrsets.recursiveUpdate { } (map forSystem systems)
