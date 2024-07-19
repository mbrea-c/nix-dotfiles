{ inputs, colorscheme, ... }:
let
  u = inputs.nix-color-utils.lib;
  colors = u.fromBase16 colorscheme;
in {
  "IblIndent" = { fg = u.hsv.lighten 0.1 colors.background; };
  "IblScope" = {
    fg = u.hsv.lighten 0.25 colors.background;
    bold = true;
  };
}
