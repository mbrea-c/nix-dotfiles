{ nix-color-utils, ... }:
{
  config,
  ...
}:
let
  palette = config.dotcolors.palette;
  u = nix-color-utils.lib;
  saturate = u.color.hsvSaturate;
in
{
  custom.colorscheme = {
    "Directory" = {
      fg = saturate 0.2 palette.blue;
      bold = true;
    };
    "NeoTreeDirectoryIcon" = {
      link = "Directory";
    };
    "NeoTreeDirectoryName" = {
      link = "Directory";
    };

    # nvim-tree
    "NvimTreeOpenedHL" = {
      underdotted = true;
    };
    "NvimTreeIndentMarker" = {
      fg = config.custom.colorscheme.Directory.fg;
    };
    "NvimTreeFolderIcon" = {
      fg = config.custom.colorscheme.Directory.fg;
    };
    "NvimTreeSpecialFile" = {
      fg = palette.yellow;
    };
    "NvimTreeExecFile" = {
      fg = palette.green;
    };
    "NvimTreeImageFile" = {
      fg = palette.color5;
    };
  };
}
