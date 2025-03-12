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
  "TabLineFill" = { bg = lighten 0.15 colors.background; };
  "TabLine" = {
    fg = colors.background;
    bg = colors.color8;
  };
  "TabLineSel" = {
    fg = colors.foreground;
    bg = colors.background;
    # bold = true;
  };
}
