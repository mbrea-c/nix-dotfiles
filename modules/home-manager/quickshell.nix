{ pkgs, ... }:
let
  systemd-utils = (import ../../utils/systemd.nix) { };
in
{
  xdg.configFile = {
    "quickshell" = {
      source = ../../../dotfiles/quickshell;
      recursive = true;
    };
  };

  systemd.user.services = {
    mako-srv = systemd-utils.make-session-service {
      target = "sway-session.target";
      desc = "Quickshell";
      exec = "${pkgs.quickshell}/bin/quickshell";
    };
  };

  home.packages = [ pkgs.quickshell ];
}
