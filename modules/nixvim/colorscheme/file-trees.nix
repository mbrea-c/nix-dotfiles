{ inputs, colorscheme, ... }:
let
  u = inputs.nix-color-utils.lib;
  colors = u.fromBase16 colorscheme;
in {
  "Directory" = {
    fg = u.hsv.saturate 0.2 colors.blue;
    bold = true;
  };
  "NeoTreeDirectoryIcon" = { link = "Directory"; };
  "NeoTreeDirectoryName" = { link = "Directory"; };
}
