{ lib, inputs, colorscheme, ... }:
let
  u = (import ../colorschemeUtils.nix) { inherit lib inputs; };
  colors = u.fromBase16 colorscheme;
in {
  "NeoTreeDirectoryIcon" = { fg = colors.blue; };
  "NeoTreeDirectoryName" = { fg = colors.blue; };
}
