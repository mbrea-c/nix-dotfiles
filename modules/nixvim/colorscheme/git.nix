{ inputs, colorscheme, ... }:
let
  u = inputs.nix-color-utils.lib;
  colors = u.fromBase16 colorscheme;
in {
  custom.colorscheme = {
    "Changed" = { fg = colors.yellow; };
    "GitSignsCurrentLineBlame" = { fg = colors.color8; };
  };
}
