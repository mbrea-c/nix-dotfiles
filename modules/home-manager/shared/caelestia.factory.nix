{ caelestia-shell, ... }:
{ pkgs, ... }:
let
  flakeRoot = ../../../.;
  systemd-utils = (import (flakeRoot + /utils/systemd.nix)) { };
in
{
  imports = [ caelestia-shell.homeManagerModules.default ];
  home.packages = [ caelestia-shell.packages."${pkgs.system}".default ];

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
        theme.enableGtk = false;
      };
    };
  };

  systemd.user.services = {
    quickshell = systemd-utils.make-session-service {
      target = "hyprland-session.target";
      desc = "Caelestia shell";
      exec = "${pkgs.quickshell}/bin/quickshell";
    };
  };

}
