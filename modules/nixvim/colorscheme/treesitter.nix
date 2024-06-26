{ lib, inputs, colorscheme, ... }:
let
  u = (import ../colorschemeUtils.nix) { inherit lib inputs; };
  palette = colorscheme.palette;
  background = u.background colorscheme;
  foreground = u.foreground colorscheme;
in {
  "@note" = {
    fg = u.background colorscheme;
    bg = palette.base05;
  };
  "@comment" = { fg = palette.base08; };
  "@comment.documentation" = {
    fg = u.lighten 0.2 palette.base08;
    italic = true;
  };
  "@warning" = {
    fg = u.background colorscheme;
    bg = palette.base05;
  };
  "@danger" = {
    fg = u.background colorscheme;
    bg = palette.base03;
  };
  "@constructor" = { fg = palette.base06; };
  "@conditional" = { fg = palette.base02; };
  "@constant" = {
    fg = u.darken 0.1 palette.base06;
    bold = true;
  };
  "@field" = { fg = u.darken 0.1 palette.base06; };
  "@function" = { fg = u.darken 0.2 palette.base02; };
  "@keyword" = {
    fg = palette.base02;
    bold = true;
  };
  "@keyword.function" = {
    fg = u.darken 0.2 palette.base02;
    bold = true;
  };
  "@label" = { fg = palette.base07; };
  "@method" = {
    fg = palette.base06;
    bold = true;
  };
  "@namespace" = {
    fg = palette.base06;
    bold = true;
  };
  "@number" = { fg = u.lighten 0.1 palette.base01; };
  "@float" = { fg = u.mixHSV 0.5 palette.base01 palette.base6; };
}
