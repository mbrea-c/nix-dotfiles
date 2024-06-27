{ lib, inputs, colorscheme, ... }:
let
  u = (import ../colorschemeUtils.nix) { inherit lib inputs; };
  colors = u.fromBase16 colorscheme;
in { }
