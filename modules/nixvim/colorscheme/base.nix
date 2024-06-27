{ inputs, colorscheme, ... }:
let
  u = inputs.nix-color-utils.lib;
  colors = u.fromBase16 colorscheme;
  inherit (u.hsv) lighten darken;
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

  "NormalNC" = {
    fg = colors.foreground;
    bg = colors.background;
  };
  "Pmenu" = {
    fg = colors.foreground;
    bg = colors.background;
  };
  "PmenuSel" = {
    fg = colors.background;
    bg = colors.blue;
  };
  "WildMenu" = {
    fg = colors.color7;
    bg = colors.blue;
  };
  "Comment" = { fg = colors.color8; };
  "Folded" = {
    fg = colors.blue;
    bg = colors.background;
  };
  "FoldColumn" = {
    fg = colors.blue;
    bg = colors.background;
  };
  "LineNr" = {
    fg = colors.color8;
    bg = darken 0.1 colors.background;
  };
  "CursorLineNr" = {
    fg = lighten 0.3 colors.color8;
    bold = true;
  };
  "CursorLine" = { bg = lighten 0.1 colors.background; };
  "CursorColumn" = { bg = colors.background; };
  #"ColorColumn" = { bg = colors.background; }; what is this?
  "FloatBorder" = { fg = darken 0.3 colors.foreground; };
  "NormalFloat" = { bg = darken 0.15 colors.background; };

  "WinSeparator" = {
    fg = colors.background;
    bg = colors.color8;
  };

  "Visual" = { bg = colors.color8; };
}
