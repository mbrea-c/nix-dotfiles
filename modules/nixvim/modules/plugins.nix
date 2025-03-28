# This module just imports all of the active plugin modules
{ ... }:
let
  files = builtins.map ({ key, ... }: key)
    (builtins.filter ({ value, ... }: value == "regular")
      (builtins.mapAttrs (key: value: { inherit key value; })
        (builtins.readDir ./plugins)));
in { imports = files; }
