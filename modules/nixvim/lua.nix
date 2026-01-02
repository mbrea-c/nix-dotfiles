# This module just imports all of the active plugin modules
{ lib, ... }:
let
  nu = (import ../../utils/nix-utils.nix) { inherit lib; };
  directory = ./plugins;
  files = nu.allFilesInDir ".lua" directory;
in {
  extraFiles = builtins.trace (builtins.listToAttrs (map (file: {
    name = "lua/" + (builtins.baseNameOf file);
    value = { source = file; };
  }) files)) (builtins.listToAttrs (map (file: {
    name = "lua/" + (builtins.baseNameOf file);
    value = { source = file; };
  }) files));
}
