# This module just imports all of the active plugin modules
{ ... }:
let
  files = builtins.attrNames
    (builtins.filterAttrs (name: type: type == "regular")
      (builtins.readDir ./plugins));
in { imports = files; }
