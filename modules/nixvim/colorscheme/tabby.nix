{ inputs, colorscheme, ... }:
let
  u = inputs.nix-color-utils.lib;
  colors = u.fromBase16 colorscheme;
  inherit (u.hsv) lighten;
in {
  custom.colorscheme = {
    "TabbyFill" = { bg = lighten 0.15 colors.background; };
    "TabbyHead" = {
      fg = colors.background;
      bg = colors.color8;
    };
    "TabbyCurrentTab" = {
      fg = colors.foreground;
      bg = colors.background;
      bold = true;
    };
    # "TabbyCurrentTabSep" = {
    #   fg = colors.background;
    #   bg = lighten 0.15 colors.background;
    # };
    "TabbyTab" = {
      fg = colors.background;
      bg = colors.color8;
    };
    # "TabbyTabSep" = {
    #   fg = colors.color8;
    #   bg = lighten 0.15 colors.background;
    # };
    # "TabLine" = { };
    "TabbyTail" = {
      fg = colors.background;
      bg = colors.color8;
    };
    "TabbyWin" = {
      fg = colors.background;
      bg = colors.color8;
    };
  };
}
