{
  inputs,
  palette,
  ...
}:
let
  cu = inputs.nix-color-utils.lib.color;
in
{
  custom.colorscheme = {
    MiniMapNormal = {
      fg = cu.hsvDarken 0.25 palette.foreground;
      bg = cu.hsvDarken 0.10 palette.background;
      blend = 10;
    };
  };
}
