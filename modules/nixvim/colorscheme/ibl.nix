{ inputs, colorscheme, ... }:
let
  u = inputs.nix-color-utils.lib;
  colors = u.fromBase16 colorscheme;
in {
  "IblIndent" = { fg = colors.color8; };
  "IblScope" = {
    fg = u.hsv.lighten 0.15 colors.color8;
    bold = true;
  };
}
