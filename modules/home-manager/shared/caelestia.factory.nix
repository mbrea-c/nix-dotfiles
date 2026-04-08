{ caelestia-shell, ... }:
{ pkgs, ... }:
let
  flakeRoot = ../../../.;
  systemd-utils = (import (flakeRoot + /utils/systemd.nix)) { };
  caelestia-shell-pkg = caelestia-shell.packages."${pkgs.system}".default;
in
{
  imports = [ caelestia-shell.homeManagerModules.default ];

  programs.caelestia = {
    enable = true;
    systemd = {
      enable = false; # if you prefer starting from your compositor
    };
    settings = {
      paths.wallpaperDir = "~/Pictures/wallpapers";
    };
    cli = {
      enable = true; # Also add caelestia-cli to path
      settings = {
        theme = {
          enableTerm = false;
          enableGtk = true;
          enableQt = true;
        };
      };
    };
  };

  systemd.user.services = {
    caelestia = systemd-utils.make-session-service {
      target = "hyprland-session.target";
      desc = "Caelestia shell";
      exec = "${caelestia-shell-pkg}/bin/caelestia-shell";
    };
  };
}
