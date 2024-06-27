{ lib, inputs, colorscheme, ... }:
let
  u = (import ../colorschemeUtils.nix) { inherit lib inputs; };
  colors = u.fromBase16 colorscheme;
  inherit (u) lighten darken saturate;
in {
  "NeoTreeDirectoryIcon" = { fg = colors.blue; };
  "NeoTreeDirectoryName" = { fg = colors.blue; };
}
