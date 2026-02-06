{ ... }:
{ config, ... }:
let
  palette = config.dotcolors.palette;
in
{
  custom.colorscheme = {
    "Changed" = {
      fg = palette.yellow;
    };
    "GitSignsCurrentLineBlame" = {
      fg = palette.color8;
    };
  };
}
