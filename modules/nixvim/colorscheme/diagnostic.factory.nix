{ nix-color-utils, ... }:
{ config, ... }:
let
  palette = config.dotcolors.palette;
  u = nix-color-utils.lib;
  lighten = u.color.hsvLighten;
  saturate = u.color.hsvSaturate;
  error = saturate 0.3 (lighten 0.3 palette.red);
  warning = saturate 0.3 (lighten 0.3 palette.yellow);
  info = lighten 0.5 palette.foreground;
  hint = saturate 0.3 (lighten 0.3 palette.blue);
in
{
  custom.colorscheme = {
    # Error highlights in text
    "DiagnosticError" = {
      fg = error;
    };
    "DiagnosticWarn" = {
      fg = warning;
    };
    "DiagnosticInfo" = {
      fg = info;
    };
    "DiagnosticHint" = {
      fg = hint;
    };
    "DiagnosticUnnecessary" = {
      link = "DiagnosticHint";
    };

    # Underlines
    "DiagnosticUnderlineError" = {
      undercurl = true;
      sp = error;
    };
    "DiagnosticUnderlineWarn" = {
      undercurl = true;
      sp = warning;
    };
    "DiagnosticUnderlineInfo" = {
      undercurl = true;
      sp = info;
    };
    "DiagnosticUnderlineHint" = {
      undercurl = true;
      sp = hint;
    };

    # Sign column
    "DiagnosticSignError" = {
      fg = error;
    };
    "DiagnosticSignWarn" = {
      fg = warning;
    };
    "DiagnosticSignInfo" = {
      fg = info;
    };
    "DiagnosticSignHint" = {
      fg = hint;
    };

    # For mini.map plugin highlights
    "DiagnosticMiniError" = {
      fg = palette.background;
      bg = error;
    };
    "DiagnosticMiniWarn" = {
      fg = palette.background;
      bg = warning;
    };
    "DiagnosticMiniInfo" = {
      fg = palette.background;
      bg = info;
    };
    "DiagnosticMiniHint" = {
      fg = palette.background;
      bg = hint;
    };
  };
}
