{ inputs, palette, ... }:
let
  u = inputs.nix-color-utils.lib;
  lighten = u.color.hsvLighten;
in
{
  custom.colorscheme = {
    "TabbyFill" = {
      bg = lighten 0.15 palette.background;
    };
    "TabbyHead" = {
      fg = palette.background;
      bg = palette.color8;
    };
    "TabbyCurrentTab" = {
      fg = palette.foreground;
      bg = palette.background;
      bold = true;
    };
    # "TabbyCurrentTabSep" = {
    #   fg = colors.background;
    #   bg = lighten 0.15 colors.background;
    # };
    "TabbyTab" = {
      fg = palette.background;
      bg = palette.color8;
    };
    # "TabbyTabSep" = {
    #   fg = colors.color8;
    #   bg = lighten 0.15 colors.background;
    # };
    # "TabLine" = { };
    "TabbyTail" = {
      fg = palette.background;
      bg = palette.color8;
    };
    "TabbyWin" = {
      fg = palette.background;
      bg = palette.color8;
    };
  };
}
