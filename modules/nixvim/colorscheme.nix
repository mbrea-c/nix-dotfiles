{ lib, inputs, config, ... }:
let
  u = inputs.nix-color-utils.lib;
  nu = (import ../../utils/nix-utils.nix) { inherit lib; };
  directory = ./colorscheme;
in {
  imports = (nu.allFilesInDir ".nix" directory);
  options = {
    custom = {
      colorscheme = with lib;
        mkOption {
          type = types.attrsOf types.anything;
          default = { };
          description = "Configure a custom colorscheme";
        };
    };
  };
  config = { highlightOverride = u.mapColors config.custom.colorscheme; };
}
