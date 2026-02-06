{ inputs, palette, ... }:
let
  u = inputs.nix-color-utils.lib;
  lighten = u.color.hsvLighten;
  saturate = u.color.hsvSaturate;
  error = saturate 0.3 (lighten 0.3 palette.red);
  warning = saturate 0.3 (lighten 0.3 palette.yellow);
  info = lighten 0.5 palette.foreground;
  hint = saturate 0.3 (lighten 0.3 palette.blue);
in
{
  custom.colorscheme = {
    # The *Handle colors are applier when the sign is on top of the handle
    # Otherwise, the regular group is applied
    "ScrollbarHandle" = {
      bg = palette.color8;
    };
    "ScrollbarCursorHandle" = {
      fg = palette.foreground;
      bg = palette.color8;
    };
    "ScrollbarErrorHandle" = {
      fg = error;
      bg = palette.color8;
    };
    "ScrollbarWarnHandle" = {
      fg = warning;
      bg = palette.color8;
    };
    "ScrollbarInfoHandle" = {
      fg = info;
      bg = palette.color8;
    };
    "ScrollbarHintHandle" = {
      fg = hint;
      bg = palette.color8;
    };
    "ScrollbarCursor" = {
      fg = palette.foreground;
    };
    "ScrollbarError" = {
      fg = error;
    };
    "ScrollbarWarn" = {
      fg = warning;
    };
    "ScrollbarInfo" = {
      fg = info;
    };
    "ScrollbarHint" = {
      fg = hint;
    };
  };
}
