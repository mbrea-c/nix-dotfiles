{ inputs, palette, ... }:
let
  u = inputs.nix-color-utils.lib;
  lighten = u.color.hsvLighten;
  darken = u.color.hsvDarken;
  matchValue = u.color.hsvMatchValue;
in
{
  custom.colorscheme = {
    "Normal" = {
      fg = palette.foreground;
      bg = palette.background;
    };
    "StatusLineNC" = {
      fg = palette.background;
      bg = palette.color8;
    };
    "StatusLine" = {
      fg = palette.background;
      bg = palette.foreground;
    };
    "SignColumn" = {
      bg = darken 0.1 palette.background;
      fg = palette.background;
    };
    "MsgArea" = {
      fg = palette.foreground;
      bg = palette.background;
    };
    "ModeMsg" = {
      fg = palette.foreground;
      bg = palette.background;
    };
    "MsgSeparator" = {
      fg = palette.foreground;
      bg = palette.background;
    };

    # Highlight references of symbol under cursor
    "LspReferenceText" = {
      bg = lighten 0.2 palette.background;
    };
    "LspReferenceRead" = {
      bg = lighten 0.2 palette.background;
      italic = true;
    };
    "LspReferenceWrite" = {
      bg = lighten 0.2 palette.background;
      bold = true;
    };
    "LspInlayHint" = {
      fg = lighten 0.2 palette.background;
    };

    # Spelling
    "SpellBad" = {
      fg = palette.color1;
      undercurl = true;
    };
    "SpellCap" = {
      fg = palette.color5;
      undercurl = true;
    };
    "SpellLocal" = {
      fg = palette.color3;
      undercurl = true;
    };
    "SpellRare" = {
      fg = palette.color6;
      undercurl = true;
    };

    "NormalNC" = {
      fg = palette.foreground;
      bg = palette.background;
    };

    "BlinkCmpMenuBorder" = {
      link = "FloatBorder";
    };
    "BlinkCmpSignatureHelpBorder" = {
      link = "FloatBorder";
    };
    "BlinkCmpDocBorder" = {
      link = "FloatBorder";
    };

    "Pmenu" = {
      fg = palette.foreground;
      bg = palette.background;
    };
    "PmenuSel" = {
      fg = palette.background;
      bg = palette.blue;
    };
    "WildMenu" = {
      fg = palette.color7;
      bg = palette.blue;
    };
    "Comment" = {
      fg = palette.color8;
    };
    "Folded" = {
      fg = palette.blue;
      bg = palette.background;
    };
    "FoldColumn" = {
      fg = palette.blue;
      bg = palette.background;
    };
    "LineNr" = {
      fg = palette.color8;
      bg = darken 0.1 palette.background;
    };
    "CursorLineNr" = {
      fg = lighten 0.3 palette.color8;
      bold = true;
    };
    "CursorLine" = {
      bg = lighten 0.1 palette.background;
    };
    "CursorColumn" = {
      bg = palette.background;
    };
    #"ColorColumn" = { bg = colors.background; }; what is this?
    "FloatBorder" = {
      fg = darken 0.25 palette.blue;
      # bg = darken 0.15 colors.background;
      bg = matchValue (palette.background) palette.blue;
      blend = 12;
    };
    "NormalFloat" = {
      # bg = darken 0.15 colors.background;
      bg = matchValue (palette.background) palette.blue;
      blend = 12;
    };

    "WinSeparator" = {
      fg = lighten 0.15 palette.color8;
    };

    "Visual" = {
      bg = palette.color8;
    };
    "VisualNOS" = {
      bg = palette.color8;
      fg = palette.red;
    };
  };
}
