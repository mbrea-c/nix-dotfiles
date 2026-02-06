# This is a module factory
params@{
  blender-autorender,
  nix-colors,
  nix-color-utils,
  nixvim,
  ...
}:
{
  pkgs,
  lib,
  config,
  ...
}:
let
  flakeRoot = ../../../.;
  manuvim = nixvim.legacyPackages."${pkgs.stdenv.hostPlatform.system}".makeNixvimWithModule {
    inherit pkgs;
    module = {
      imports = [
        (import (flakeRoot + /modules/nixvim/manuvim.factory.nix) params)
        # forward colorscheme configuration
        { dotcolors = config.dotcolors; }
      ];
    };
  };

  envVars = {
    EDITOR = "${manuvim}/bin/nvim";
  };
in
{
  home.packages = [ manuvim ];

  home.sessionVariables = envVars;
  systemd.user.sessionVariables = envVars;
}
