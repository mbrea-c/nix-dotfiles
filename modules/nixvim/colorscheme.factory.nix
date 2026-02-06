params@{ nix-color-utils, ... }:
{
  lib,
  config,
  ...
}:
let
  flakeRoot = ../../.;
  u = nix-color-utils.lib;
  nu = (import (flakeRoot + /utils/nix-utils.nix)) { inherit lib; };
  directory = ./colorscheme;
in
{
  imports = (nu.allFactoriesInDir params directory);

  options = {
    custom = {
      colorscheme =
        with lib;
        mkOption {
          type = types.attrsOf types.anything;
          default = { };
          description = "Configure a custom colorscheme";
        };
    };
  };

  config = {
    highlightOverride = u.compileNeovimColors config.custom.colorscheme;
  };
}
