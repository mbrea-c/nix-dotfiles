# This module just imports all of the active plugin modules
{ lib, ... }:
let
  nu = (import ../../utils/nix-utils.nix) { inherit lib; };
  directory = ./plugins;
in { imports = (nu.allFilesInDir ".nix" directory); }
