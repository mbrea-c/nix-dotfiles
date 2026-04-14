params@{ caelestia-shell, ... }:
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

  flattenedGenLists = end: func: builtins.concatLists (builtins.genList func end);
in
{
  imports = [
    (import ./caelestia.factory.nix params)
  ];
  wayland.windowManager.hyprland = {
    enable = true;

    # Installed in system module
    package = null;

    systemd.enable = true;

    settings = {
      "$mod" = "SUPER";

      "$menu" = "rofi -dmenu -matching fuzzy";
      "$menu_launcher" = "rofi -show drun -matching fuzzy -show-icons";

      animation = [
        "windows, 1, 1, default"
      ];
      bind = [
        # Move focus with vim keys
        "$mod, h, movefocus, l"
        "$mod, j, movefocus, d"
        "$mod, k, movefocus, u"
        "$mod, l, movefocus, r"

        "$mod SHIFT, h, movewindow, l"
        "$mod SHIFT, j, movewindow, d"
        "$mod SHIFT, k, movewindow, u"
        "$mod SHIFT, l, movewindow, r"

        "$mod, Q, killactive"
        "$mod, F, fullscreen, 0, toggle"
        "$mod, b, layoutmsg, togglesplit"
        "$mod SHIFT, Space, togglefloating"

        # Reload desktop configs
        "$mod SHIFT, c, exec, hyprctl reload"
        "$mod SHIFT, c, exec, systemctl --user restart caelestia.service"

        "$mod, Return, exec, kitty"

        "$mod, d, global, caelestia:launcher"
        "$mod, s, global, caelestia:sidebar"
        "$mod SHIFT, e, global, caelestia:session"
      ]
      ++ flattenedGenLists 10 (
        i:
        let
          ws = i + 1;
          mod = a: b: a - (builtins.div a b) * b;
          key = mod ws 10;
        in
        [
          "$mod, ${toString key}, workspace, ${toString ws}"
          "$mod SHIFT, ${toString key}, movetoworkspace, ${toString ws}"
        ]
      );
      bindm = [
        "$mod, mouse:272, movewindow"
        "$mod, mouse:273, resizewindow"
      ];

      bindl = [
        # Media
        "$mod CTRL, Space, global, caelestia:mediaToggle"
        ", XF86AudioPlay, global, caelestia:mediaToggle"
        ", XF86AudioPause, global, caelestia:mediaToggle"
        "$mod CTRL, Equal, global, caelestia:mediaNext"
        ", XF86AudioNext, global, caelestia:mediaNext"
        "$mod CTRL, Minus, global, caelestia:mediaPrev"
        ", XF86AudioPrev, global, caelestia:mediaPrev"
        ", XF86AudioStop, global, caelestia:mediaStop"

        # Brightness
        ", XF86MonBrightnessUp, global, caelestia:brightnessUp"
        ", XF86MonBrightnessDown, global, caelestia:brightnessDown"

        # Audio
        ", XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
        ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
      ];

      bindle = [
        ", XF86AudioRaiseVolume, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ 0; wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"
        ", XF86AudioLowerVolume, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ 0; wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
      ];
      workspace =
        let
          laptopMonitor = "BOE 0x0BC9";
          externalMonitor = "Dell Inc. DELL S2721DGF GV1KT83";
        in
        [
          "1,  monitor:desc:${laptopMonitor}, default:true"
          "2,  monitor:desc:${laptopMonitor}"
          "3,  monitor:desc:${laptopMonitor}"
          "4,  monitor:desc:${laptopMonitor}"
          "5,  monitor:desc:${laptopMonitor}"
          "6,  monitor:desc:${externalMonitor}, default:true"
          "7,  monitor:desc:${externalMonitor}"
          "8,  monitor:desc:${externalMonitor}"
          "9,  monitor:desc:${externalMonitor}"
          "10, monitor:desc:${externalMonitor}"
        ];

      general = {
        gaps_out = 8;
        gaps_in = 4;
      };

      decoration = {
        rounding = 5;
      };

      dwindle = {
        preserve_split = true;
      };

      misc = {
        force_default_wallpaper = 0;
      };
    };
  };

  systemd.user.services = {
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

  xdg.configFile = {
    "gammastep" = {
      source = flakeRoot + /dotfiles/gammastep;
      recursive = true;
    };
  };
}
