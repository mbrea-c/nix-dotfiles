{ nix-color-utils, ... }:
{ config, ... }:
let
  palette = config.dotcolors.palette;
  u = nix-color-utils.lib;
  lighten = u.color.hsvLighten;
in
{
  custom.colorscheme = {
    "IblIndent" = {
      fg = lighten 0.1 palette.background;
    };
    "IblScope" = {
      fg = lighten 0.25 palette.background;
      bold = true;
    };
  };
}
