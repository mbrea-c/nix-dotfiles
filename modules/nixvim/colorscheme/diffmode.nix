{ inputs, colorscheme, ... }:
let
  u = inputs.nix-color-utils.lib;
  colors = u.fromBase16 colorscheme;
in {
  custom.colorscheme = {
    "DiffAdd" = { bg = u.rgb.mix 0.3 colors.background colors.green; };
    "DiffChange" = { bg = u.rgb.mix 0.3 colors.background colors.yellow; };
    "DiffDelete" = {
      bg = u.rgb.mix 0.3 colors.background colors.red;
      fg = colors.background;
    };
    "DiffText" = {
      bg = u.rgb.mix 0.4 colors.background colors.yellow;
      bold = true;
      italic = true;
      undercurl = true;
    };
  };
}
