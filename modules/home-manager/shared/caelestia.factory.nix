{ caelestia-shell, ... }:
{ pkgs, ... }:
let
  flakeRoot = ../../../.;
  systemd-utils = (import (flakeRoot + /utils/systemd.nix)) { };
  caelestia-shell-pkg = caelestia-shell.packages."${pkgs.stdenv.hostPlatform.system}".default;
in
{
  imports = [ caelestia-shell.homeManagerModules.default ];

  home.packages = with pkgs; [
    adw-gtk3
    rubik
  ];

  programs.caelestia = {
    enable = true;
    systemd = {
      enable = false; # if you prefer starting from your compositor
    };
    settings = {
      paths.wallpaperDir = "~/Pictures/wallpapers";
      launcher = {
        vimKeybinds = true;
      };
      session = {
        vimKeybinds = true;
      };
      appearance = {
        rounding.scale = 0.5;
        font = {
          family = {
            clock = "sans-serif";
            material = "Material Symbols Rounded";
            mono = "monospace";
            sans = "sans-serif";
          };
        };
      };
      services = {
        useFahrenheit = false;
        useFahrenheitPerformance = false;
        smartScheme = true;
      };
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
