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
        # Move focus with vim keys
        "$mod, h, movefocus, l"
        "$mod, j, movefocus, d"
        "$mod, k, movefocus, u"
        "$mod, l, movefocus, r"

        "$mod, Return, exec, kitty"
        "$mod SHIFT, C, exec, hyprctl reload"
      ]
      ++ builtins.concatLists (
        builtins.genList (
          i:
          let
            ws = i + 1;
            mod = a: b: a - (builtins.div a b) * b;
            key = mod ws 10;
          in
          [
            "$mod, code:1${toString key}, workspace, ${toString ws}"
            "$mod SHIFT, code:1${toString key}, movetoworkspace, ${toString ws}"
          ]
        ) 9
      );
      bindm = [
        "$mod, mouse:272, movewindow"
        "$mod, mouse:273, resizewindow"
      ];
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
