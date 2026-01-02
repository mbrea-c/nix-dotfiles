# This module just imports all of the active plugin modules
{ lib, ... }:
let
  nu = (import ../../utils/nix-utils.nix) { inherit lib; };
  directory = ./lua;
  files = nu.allFilesInDir ".lua" directory;
in {
  extraFiles = builtins.listToAttrs (map (file: {
    name = "lua/" + (builtins.baseNameOf file);
    value = { source = file; };
  }) files);
}
