{ lib, colorscheme, ... }:
let
  u = (import ./colorschemeUtils.nix) { };
  colors = colorscheme;
in {
  "@note" = {
    fg = u.background colors;
    bg = colors.base05;
  };
  "@comment" = { fg = colors.base08; };
}
