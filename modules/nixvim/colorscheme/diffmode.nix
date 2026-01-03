{ inputs, palette, ... }:
let
  u = inputs.nix-color-utils.lib;
  mix = u.color.rgbMix;
in
{
  custom.colorscheme = {
    "DiffAdd" = {
      bg = mix 0.3 palette.background palette.green;
    };
    "DiffChange" = {
      bg = mix 0.3 palette.background palette.yellow;
    };
    "DiffDelete" = {
      bg = mix 0.3 palette.background palette.red;
      fg = palette.background;
    };
    "DiffText" = {
      bg = mix 0.4 palette.background palette.yellow;
      bold = true;
      italic = true;
      undercurl = true;
    };
  };
}
