{ palette, inputs, ... }:
let
  u = inputs.nix-color-utils.lib;
  darken = u.color.hsvDarken;
  saturate = u.color.hsvSaturate;
in
{
  custom.colorscheme = {
    "AerialLine" = {
      fg = saturate 0.2 palette.blue;
      bold = true;
    };
    "AerialFunctionIcon" = {
      fg = darken 0.1 palette.magenta;
    };
    "AerialStructIcon" = {
      fg = darken 0.1 palette.red;
    };
    "AerialClassIcon" = {
      fg = darken 0.1 palette.green;
    };
  };
}
