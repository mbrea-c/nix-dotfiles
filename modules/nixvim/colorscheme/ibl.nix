{ inputs, colorscheme, ... }:
let
  u = inputs.nix-color-utils.lib;
  colors = u.fromBase16 colorscheme;
in {
  "IblScope" = {
    fg = colors.color8;
    bold = true;
  };
}
