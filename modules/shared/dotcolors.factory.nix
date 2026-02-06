{ nix-color-utils, nix-colors, ... }:
{ lib, ... }:
{
  options = {
    dotcolors = {
      palette = lib.mkOption {
        type = lib.types.attrsOf lib.types.anything;
        default = nix-color-utils.lib.paletteFromNixColorsColorscheme nix-colors.colorSchemes.gruvbox-dark-medium;
      };
    };
  };
}
