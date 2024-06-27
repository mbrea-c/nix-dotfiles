{ lib, inputs, colorscheme, ... }:
let
  u = (import ../colorschemeUtils.nix) { inherit lib inputs; };
  colors = u.fromBase16 colorscheme;
  inherit (u) lighten darken saturate;
in {
  "NeoTreeFileIcon" = { fg = colors.blue; };
  "NeoTreeFileName" = { fg = colors.foreground; };
}
