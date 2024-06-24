{ lib, colorscheme, ... }:
let
  u = (import ./colorschemeUtils.nix) { inherit lib; };
  palette = colorscheme.palette;
in u.mapColors {
  # "@note" = {
  #   fg = u.background colorscheme;
  #   bg = palette.base05;
  # };
  # "@comment" = { fg = palette.base08; };
}
