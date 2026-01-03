{ inputs, colorscheme, config, ... }:
let
  u = inputs.nix-color-utils.lib;
  colors = u.fromBase16 colorscheme;
in {
  custom.colorscheme = {
    "Directory" = {
      fg = u.hsv.saturate 0.2 colors.blue;
      bold = true;
    };
    "NeoTreeDirectoryIcon" = { link = "Directory"; };
    "NeoTreeDirectoryName" = { link = "Directory"; };

    # nvim-tree
    "NvimTreeOpenedHL" = { underdotted = true; };
    "NvimTreeIndentMarker" = { fg = config.custom.colorscheme.Directory.fg; };
    "NvimTreeFolderIcon" = { fg = config.custom.colorscheme.Directory.fg; };
    "NvimTreeSpecialFile" = { fg = colors.yellow; };
    "NvimTreeExecFile" = { fg = colors.green; };
    "NvimTreeImageFile" = { fg = colors.color5; };
  };
}
