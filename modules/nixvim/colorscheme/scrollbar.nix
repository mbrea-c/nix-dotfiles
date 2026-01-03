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
    # The *Handle colors are applier when the sign is on top of the handle
    # Otherwise, the regular group is applied
    "ScrollbarHandle" = { bg = colors.color8; };
    "ScrollbarCursorHandle" = {
      fg = colors.foreground;
      bg = colors.color8;
    };
    "ScrollbarErrorHandle" = {
      fg = error;
      bg = colors.color8;
    };
    "ScrollbarWarnHandle" = {
      fg = warning;
      bg = colors.color8;
    };
    "ScrollbarInfoHandle" = {
      fg = info;
      bg = colors.color8;
    };
    "ScrollbarHintHandle" = {
      fg = hint;
      bg = colors.color8;
    };
    "ScrollbarCursor" = { fg = colors.foreground; };
    "ScrollbarError" = { fg = error; };
    "ScrollbarWarn" = { fg = warning; };
    "ScrollbarInfo" = { fg = info; };
    "ScrollbarHint" = { fg = hint; };
  };
}
