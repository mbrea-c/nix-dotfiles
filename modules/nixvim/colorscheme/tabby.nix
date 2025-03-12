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
  "TabbyFill" = { bg = lighten 0.3 colors.background; };
  "TabbyHead" = {
    fg = colors.background;
    bg = colors.color8;
  };
  "TabbyCurrentTab" = {
    fg = colors.foreground;
    bg = colors.background;
  };
  "TabbyCurrentTabSep" = {
    fg = colors.background;
    bg = lighten 0.3 colors.background;
  };
  "TabbyTab" = {
    fg = colors.background;
    bg = colors.color8;
  };
  "TabbyTabSep" = {
    fg = colors.color8;
    bg = lighten 0.3 colors.background;
  };
  # "TabLine" = { };
  # "TabbyTail" = { };
}
