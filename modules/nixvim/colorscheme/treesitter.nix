{ lib, inputs, colorscheme, ... }:
let
  u = (import ../colorschemeUtils.nix) { inherit lib inputs; };
  palette = colorscheme.palette;
in {
  "@note" = {
    fg = u.background colorscheme;
    bg = palette.base05;
  };
  "@comment" = { fg = palette.base08; };
  # "@comment.documentation" = {
  #   fg = u.lighten palette.base08 0.2;
  #   italic = true;
  # };
  # "@warning" = {
  #   fg = u.background colorscheme;
  #   bg = palette.base05;
  # };
  # "@danger" = {
  #   fg = u.background colorscheme;
  #   bg = palette.base03;
  # };
  # "@constructor" = { fg = palette.base06; };
  # "@conditional" = { fg = palette.base02; };
  # "@constant" = {
  #   fg = u.darken palette.base06 0.1;
  #   bold = true;
  # };
}
