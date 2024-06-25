{ lib, inputs, colorscheme, ... }:
let
  u = (import ../colorschemeUtils.nix) { inherit lib inputs; };
  palette = colorscheme.palette;
  foreground = u.foreground colorscheme;
  background = u.background colorscheme;
in { }
