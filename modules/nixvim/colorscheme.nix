{ lib, colorscheme, inputs, ... }:
let
  u = (import ./colorschemeUtils.nix) { inherit lib inputs; };
  args = { inherit lib colorscheme inputs; };
in u.mapColors (import ./colorscheme/treesitter.nix args)
