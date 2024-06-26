{ lib, inputs, colorscheme, ... }:
let
  u = (import ../colorschemeUtils.nix) { inherit lib inputs; };
  palette = colorscheme.palette;
  background = u.background colorscheme;
  foreground = u.foreground colorscheme;
  inherit (u) lighten darken mixHSV desaturate saturate highlight;
in {
  "@note" = {
    fg = background;
    bg = palette.base05;
  };
  "@comment" = { fg = palette.base08; };
  "@comment.documentation" = {
    fg = lighten 0.2 palette.base08;
    italic = true;
  };
  "@warning" = {
    fg = background;
    bg = palette.base05;
  };
  "@danger" = {
    fg = background;
    bg = palette.base03;
  };
  "@constructor" = { fg = palette.base06; };
  "@conditional" = { fg = palette.base02; };
  "@constant" = {
    fg = darken 0.1 palette.base06;
    bold = true;
  };
  "@field" = { fg = darken 0.1 palette.base06; };
  "@function" = {
    fg = darken 0.2 palette.base02;
    bold = true;
  };
  "@keyword" = {
    fg = palette.base02;
    bold = true;
  };
  "@keyword.function" = {
    fg = darken 0.2 palette.base02;
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

  # Primitives
  "@number" = { fg = lighten 0.1 palette.base01; };
  "@float" = { fg = mixHSV 0.5 palette.base01 palette.base06; };
  "@string" = { fg = palette.base01; };
  "@string.regex" = { fg = palette.base07; };
  "@string.escape" = { fg = palette.base06; };
  "@boolean" = { fg = mixHSV 0.4 palette.base01 palette.base04; };

  "@operator" = {
    fg = palette.base03;
    bold = true;
  };
  "@parameter" = { fg = palette.base04; };
  "@property" = { fg = darken 0.1 palette.base06; };
  "@punctuation.delimiter" = { fg = darken 0.2 palette.base03; };
  "@punctuation.bracket" = {
    fg = highlight colorscheme 0.2 (desaturate 0.2 palette.base03);
  };
  "@punctuation.special" = { fg = palette.base03; };
  "@repeat" = { fg = palette.base02; };
  "@symbol" = { fg = darken 0.2 foreground; };
  "@type" = { fg = palette.base02; };
  "@type.qualifier" = { fg = lighten 0.1 palette.base02; };
  "@type.builtin" = { fg = darken 0.1 palette.base02; };
  "@variable" = {
    fg = desaturate 0.1 (mixHSV 0.5 palette.base04 palette.base06);
  };
  "@variable.builtin" = { fg = palette.base11; };
  "@text" = { fg = darken 0.1 foreground; };
  "@text.emphasis" = { italic = true; };
}
