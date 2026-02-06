{ pkgs, ... }:
let
  flakeRoot = ../../../.;
  systemd-utils = (import (flakeRoot + /utils/systemd.nix)) { };
in
{
  xdg.configFile = {
    "quickshell" = {
      source = flakeRoot + /dotfiles/quickshell;
      recursive = true;
    };
  };

  systemd.user.services = {
    quickshell = systemd-utils.make-session-service {
      target = "sway-session.target";
      desc = "Quickshell";
      exec = "${pkgs.quickshell}/bin/quickshell";
    };
  };

  home.packages = [ pkgs.quickshell ];
}
