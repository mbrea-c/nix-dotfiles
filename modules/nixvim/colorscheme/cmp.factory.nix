{ nix-color-utils, ... }:
{ config, ... }:
let
  palette = config.dotcolors.palette;
  u = nix-color-utils.lib;
  darken = u.color.hsvDarken;
  mix = u.color.hsvMix;
  desaturate = u.color.hsvDesaturate;
in
{
  custom.colorscheme = {
    "PMenu" = {
      link = "NormalFloat";
    };
    "CmpGhostText" = {
      fg = palette.color8;
    };
    "CmpItemAbbrDeprecated" = {
      strikethrough = true;
      fg = palette.color8;
    };
    "CmpItemAbbrMatch" = {
      fg = palette.blue;
    };
    "CmpItemAbbrMatchFuzzy" = {
      fg = palette.blue;
    };
    "CmpItemMenu" = {
      fg = palette.green;
      italic = true;
    };
    "CmpItemKindVariable" = {
      fg = darken 0.1 palette.cyan;
    };
    "CmpItemKindField" = {
      fg = darken 0.1 palette.cyan;
    };
    "CmpItemKindInterface" = {
      fg = darken 0.1 palette.cyan;
    };
    "CmpItemKindText" = {
      fg = darken 0.1 palette.green;
    };
    "CmpItemKindFunction" = {
      fg = darken 0.1 palette.magenta;
    };
    "CmpItemKindMethod" = {
      fg = darken 0.1 palette.magenta;
    };
    "CmpItemKindKeyword" = {
      fg = darken 0.1 palette.green;
    };
    "CmpItemKindProperty" = {
      fg = darken 0.1 palette.cyan;
    };
    "CmpItemKindUnit" = {
      fg = palette.foreground;
    };
    "CmpItemKindSnippet" = {
      fg = darken 0.1 palette.green;
    };
    "CmpItemKindCopilot" = {
      fg = darken 0.1 (desaturate 0.2 (mix 0.5 palette.red palette.blue));
    };
    "CmpItemKindCodeium" = {
      fg = darken 0.1 (desaturate 0.2 (mix 0.5 palette.red palette.blue));
    };
  };
}
