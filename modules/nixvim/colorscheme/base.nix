{ lib, inputs, colorscheme, ... }:
let
  u = (import ../colorschemeUtils.nix) { inherit lib inputs; };
  palette = colorscheme.palette;
  foreground = u.foreground colorscheme;
  background = u.background colorscheme;
  inherit (u) lighten darken;
in {
  "Normal" = {
    fg = foreground;
    bg = background;
  };
  "StatusLineNC" = {
    fg = background;
    bg = palette.base08;
  };
  "StatusLine" = {
    fg = background;
    bg = foreground;
  };
  "SignColumn" = {
    bg = darken 0.1 background;
    fg = background;
  };
  "MsgArea" = {
    fg = foreground;
    bg = background;
  };
  "ModeMsg" = {
    fg = foreground;
    bg = background;
  };
  "MsgSeparator" = {
    fg = foreground;
    bg = background;
  };

  # Highlight references of symbol under cursor
  "LspReferenceText" = { bg = lighten 0.2 background; };
  "LspReferenceRead" = {
    bg = lighten 0.2 background;
    italic = true;
  };
  "LspReferenceWrite" = {
    bg = lighten 0.2 background;
    bold = true;
  };

  # Spelling
  "SpellBad" = {
    fg = palette.base01;
    undercurl = true;
  };
  "SpellCap" = {
    fg = palette.base05;
    undercurl = true;
  };
  "SpellLocal" = {
    fg = palette.base03;
    undercurl = true;
  };
  "SpellRare" = {
    fg = palette.base06;
    undercurl = true;
  };
}
