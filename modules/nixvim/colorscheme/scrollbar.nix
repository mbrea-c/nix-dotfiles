{ inputs, colorscheme, ... }:
let
  u = inputs.nix-color-utils.lib;
  colors = u.fromBase16 colorscheme;
  inherit (u.hsv) lighten darken saturate;
  error = saturate 0.3 (lighten 0.3 colors.red);
  warning = saturate 0.3 (lighten 0.3 colors.yellow);
  info = lighten 0.5 colors.foreground;
  hint = saturate 0.3 (lighten 0.3 colors.blue);
in {
  "ScrollbarHandle" = { bg = colors.color8; };
  "ScrollbarCursorHandle" = { link = "ScrollbarHandle" };
  "ScrollbarError" = {
    fg = error;
    bg = colors.color8;
  };
  "ScrollbarWarn" = {
    fg = warning;
    bg = colors.color8;
  };
  "ScrollbarInfo" = {
    fg = info;
    bg = colors.color8;
  };
  "ScrollbarHint" = {
    fg = hint;
    bg = colors.color8;
  };
}
