{ lib, inputs, colorscheme, ... }:
let
  u = (import ../colorschemeUtils.nix) { inherit lib inputs; };
  colors = u.fromBase16 colorscheme;
  inherit (u) lighten darken;
in {
  "Normal" = {
    fg = colors.foreground;
    bg = colors.background;
  };
  "StatusLineNC" = {
    fg = colors.background;
    bg = colors.color8;
  };
  "StatusLine" = {
    fg = colors.background;
    bg = colors.foreground;
  };
  "SignColumn" = {
    bg = darken 0.1 colors.background;
    fg = colors.background;
  };
  "MsgArea" = {
    fg = colors.foreground;
    bg = colors.background;
  };
  "ModeMsg" = {
    fg = colors.foreground;
    bg = colors.background;
  };
  "MsgSeparator" = {
    fg = colors.foreground;
    bg = colors.background;
  };

  # Highlight references of symbol under cursor
  "LspReferenceText" = { bg = lighten 0.2 colors.background; };
  "LspReferenceRead" = {
    bg = lighten 0.2 colors.background;
    italic = true;
  };
  "LspReferenceWrite" = {
    bg = lighten 0.2 colors.background;
    bold = true;
  };

  # Spelling
  "SpellBad" = {
    fg = colors.color1;
    undercurl = true;
  };
  "SpellCap" = {
    fg = colors.color5;
    undercurl = true;
  };
  "SpellLocal" = {
    fg = colors.color3;
    undercurl = true;
  };
  "SpellRare" = {
    fg = colors.color6;
    undercurl = true;
  };
}
