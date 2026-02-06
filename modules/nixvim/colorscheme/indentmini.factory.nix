{ nix-color-utils, ... }:
{ config, ... }:
let
  palette = config.dotcolors.palette;
  u = nix-color-utils.lib;
  lighten = u.color.hsvLighten;
in
{
  custom.colorscheme = {
    "IndentLine" = {
      fg = lighten 0.1 palette.background;
    };
    "IndentLineCurrent" = {
      fg = lighten 0.35 palette.background;
      bold = true;
    };
  };
}
