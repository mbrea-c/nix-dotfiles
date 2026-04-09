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
      launcher = {
        vimKeybinds = true;
      };
      session = {
        vimKeybinds = true;
      };
      appearance = {
        rounding.scale = 0.5;
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

  # Quickfix while this is sorted: https://github.com/caelestia-dots/shell/pull/1372
  home.packages =
    let
      material-symbols-caelestia = pkgs.material-symbols.overrideAttrs (attrs: {
        postInstall = ''
          ln -s "$out/share/fonts/TTF/MaterialSymbolsRounded.ttf" "$out/share/fonts/TTF/MaterialSymbolsRounded[FILL,GRAD,opsz,wght].ttf"
          ln -s "$out/share/fonts/TTF/MaterialSymbolsOutlined.ttf" "$out/share/fonts/TTF/MaterialSymbolsOutlined[FILL,GRAD,opsz,wght].ttf"
          ln -s "$out/share/fonts/TTF/MaterialSymbolsSharp.ttf" "$out/share/fonts/TTF/MaterialSymbolsSharp[FILL,GRAD,opsz,wght].ttf"
        '';
      });
    in
    [ material-symbols-caelestia ];
}
