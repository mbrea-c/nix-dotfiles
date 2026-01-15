{
  inputs,
  palette,
  config,
  ...
}:
let
  cu = inputs.nix-color-utils.lib.color;
in
{
  custom.colorscheme = {
    "MiniMapNormal" = config.custom.colorscheme.NormalFloat // {
      fg = cu.hsvDarken 0.25 palette.foreground;
    };
  };
}
