# This module just imports all of the active plugin modules
{ ... }:
let
  directory = ./plugins;
  files = builtins.map ({ key, ... }: directory + "/${key}")
    (builtins.filter ({ value, ... }: value == "regular") (builtins.attrValues
      (builtins.mapAttrs (key: value: { inherit key value; })
        (builtins.readDir directory))));
in { imports = files; }
