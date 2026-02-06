# This module just imports all of the active plugin modules
params:
{ lib, ... }:
let
  nu = (import ../../utils/nix-utils.nix) { inherit lib; };
  directory = ./plugins;
in
{
  imports = builtins.trace (nu.factoriesOrModulesInDir params directory) (
    nu.factoriesOrModulesInDir params directory
  );
}
