{ nix-color-utils, ... }:
{
  config,
  ...
}:
let
  palette = config.dotcolors.palette;
  cu = nix-color-utils.lib.color;
in
{
  custom.colorscheme = {
    MiniMapNormal = {
      fg = cu.hsvDarken 0.25 palette.foreground;
      bg = cu.hsvDarken 0.10 palette.background;
    };
  };
}
