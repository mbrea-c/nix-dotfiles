{ inputs, colorscheme, ... }:
let
  u = inputs.nix-color-utils.lib;
  colors = u.fromBase16 colorscheme;
  inherit (u.hsv) darken;
in {
  custom.colorscheme = {
    "AerialLine" = {
      fg = u.hsv.saturate 0.2 colors.blue;
      bold = true;
    };
    "AerialFunctionIcon" = { fg = darken 0.1 colors.magenta; };
    "AerialStructIcon" = { fg = darken 0.1 colors.red; };
    "AerialClassIcon" = { fg = darken 0.1 colors.green; };
  };
}
