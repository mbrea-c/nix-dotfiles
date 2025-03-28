# This module just imports all of the active plugin modules
{ lib, ... }:
let
  nu = (import ../../../utils/nix-utils.nix) { inherit lib; };
  directory = ./plugins;
  files = (nu.compose [
    (builtins.map ({ key, ... }: directory + "/${key}"))
    (builtins.filter ({ key, ... }: lib.strings.hasSuffix ".nix" key))
    (builtins.filter ({ value, ... }: value == "regular"))
    nu.attrsToList
  ]) (builtins.readDir directory);
in { imports = files; }
