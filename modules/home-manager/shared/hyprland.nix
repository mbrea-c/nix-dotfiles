{ pkgs, ... }:
let
  flakeRoot = ../../../.;
  systemd-utils = (import (flakeRoot + /utils/systemd.nix)) { };
  make-srv =
    { desc, exec, ... }:
    systemd-utils.make-session-service {
      target = "hyprland-session.target";
      inherit desc exec;
    };
in
{
  wayland.windowManager.hyprland = {
    enable = true;

    # Installed in system module
    package = null;

    systemd.enable = true;

    settings = {
      "$mod" = "SUPER";
      bind = [
        "$mod, Return, exec, kitty"
        "$mod SHIFT, C, reload"
      ]
      ++ builtins.concatLists (
        builtins.genList (
          i:
          let
            ws = i + 1;
          in
          [
            "$mod, code:1${toString i}, workspace, ${toString ws}"
            "$mod SHIFT, code:1${toString i}, movetoworkspace, ${toString ws}"
          ]
        ) 9
      );
    };
  };

  systemd.user.services = {
    mako-srv = make-srv {
      desc = "Notification daemon";
      exec = "${pkgs.mako}/bin/mako";
    };
    gammastep-srv = make-srv {
      desc = "Night light for wayland sessions";
      exec = "${pkgs.gammastep}/bin/gammastep";
    };
    nmapplet-srv = make-srv {
      desc = "Network manager applet service";
      exec = "${pkgs.networkmanagerapplet}/bin/nm-applet";
    };
    blueman-srv = make-srv {
      desc = "Blueman bluetooth manager  service";
      exec = "${pkgs.blueman}/bin/blueman-applet";
    };
    polkit-gnome-authentication-agent-1 = make-srv {
      desc = "Polkit GNOME authentication agent";
      exec = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
    };
  };
}
