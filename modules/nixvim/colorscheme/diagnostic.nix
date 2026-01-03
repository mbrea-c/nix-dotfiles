{ inputs, colorscheme, ... }:
let
  u = inputs.nix-color-utils.lib;
  colors = u.fromBase16 colorscheme;
  inherit (u.hsv) lighten saturate;
  error = saturate 0.3 (lighten 0.3 colors.red);
  warning = saturate 0.3 (lighten 0.3 colors.yellow);
  info = lighten 0.5 colors.foreground;
  hint = saturate 0.3 (lighten 0.3 colors.blue);
in {
  custom.colorscheme = {
    # Error highlights in text
    "DiagnosticError" = { fg = error; };
    "DiagnosticWarn" = { fg = warning; };
    "DiagnosticInfo" = { fg = info; };
    "DiagnosticHint" = { fg = hint; };
    "DiagnosticUnnecessary" = { link = "DiagnosticHint"; };

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
    "DiagnosticSignError" = { fg = error; };
    "DiagnosticSignWarn" = { fg = warning; };
    "DiagnosticSignInfo" = { fg = info; };
    "DiagnosticSignHint" = { fg = hint; };

    # For mini.map plugin highlights
    "DiagnosticMiniError" = {
      fg = colors.background;
      bg = error;
    };
    "DiagnosticMiniWarn" = {
      fg = colors.background;
      bg = warning;
    };
    "DiagnosticMiniInfo" = {
      fg = colors.background;
      bg = info;
    };
    "DiagnosticMiniHint" = {
      fg = colors.background;
      bg = hint;
    };
  };
}
