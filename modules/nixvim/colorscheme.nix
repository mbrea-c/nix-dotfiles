{ lib, colorscheme, ... }:
let
  u = (import ./colorschemeUtils.nix) { };
  palette = colorscheme.palette;
in {
  "@note" = {
    fg = "#${u.background colorscheme}";
    bg = "#${palette.base05}";
  };
  "@comment" = { fg = "${palette.base08}"; };
}
