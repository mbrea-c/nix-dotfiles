# This module just imports all of the active plugin modules
{ lib, ... }:
let
  nu = ../../../utils/nix-utils.nix;
  directory = ./plugins;
  files = (nu.compose [
    (builtins.filter (lib.strings.hasSuffix ".nix"))
    (builtins.map ({ key, ... }: directory + "/${key}"))
    (builtins.filter ({ value, ... }: value == "regular"))
    builtins.attrValues
    (builtins.mapAttrs (key: value: { inherit key value; }))
  ]) (builtins.readDir directory);
in { imports = files; }
