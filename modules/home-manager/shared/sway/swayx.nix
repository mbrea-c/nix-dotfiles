{
  lib,
  config,
  pkgs,
  ...
}:
let
  flakeRoot = ../../../../.;
  cfg = config.swayx;
  outputMaker = import (flakeRoot + /utils/swayoutputmaker.nix);
  systemd-utils = (import (flakeRoot + /utils/systemd.nix)) { };
  make-srv =
    { desc, exec, ... }:
    systemd-utils.make-session-service {
      target = "sway-session.target";
      inherit desc exec;
    };
in
{
  imports = [
    ../quickshell.nix
  ];

  options = with lib; {
    swayx = {
      enable = lib.mkEnableOption "Enable Module";
      settings = mkOption {
        type = with types; attrsOf anything;
        description = "Configuration that will be used to generate the sway config file";
        default = {
          inherit
            (outputMaker {
              primary = "eDP-2";
              secondary = "Dell Inc. DELL S2721DGF GV1KT83";
              primaryScale = "1.5";
              secondaryScale = "1.0";
            })
            outputs
            workspaces
            ;
          dwt = true;
        };
      };
    };
  };

  config = lib.mkIf cfg.enable {
    systemd.user.targets.sway-session = {
      Unit = {
        Description = "Indicating that sway is running";
        BindsTo = [ "graphical-session.target" ];
        Wants = [ "graphical-session.target" ];
        Before = [ "graphical-session.target" ];
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

    xdg.configFile = {
      "sway/config" = {
        text = (import ./utils/swayconfig.nix) {
          inherit (cfg.settings) outputs workspaces dwt;
          exec = [ "sleep 5 && systemctl start --user sway-session.target" ];
        };
        recursive = true;
      };
      # "waybar" = {
      #   source = ../../../dotfiles/waybar;
      #   recursive = true;
      # };
      # "waybar/colors.css" = {
      #   text =
      #     let
      #       u = inputs.nix-color-utils.lib;
      #       colors = u.fromBase16 colorscheme;
      #       # css
      #     in
      #     ''
      #       @define-color foreground #${colors.foreground};
      #       @define-color background #${colors.background};

      #       @define-color color0  #${colors.color0};
      #       @define-color color1  #${colors.color1};
      #       @define-color color2  #${colors.color2};
      #       @define-color color3  #${colors.color3};
      #       @define-color color4  #${colors.color4};
      #       @define-color color5  #${colors.color5};
      #       @define-color color6  #${colors.color6};
      #       @define-color color7  #${colors.color7};
      #       @define-color color8  #${colors.color8};
      #       @define-color color9  #${colors.color9};
      #       @define-color color10 #${colors.color10};
      #       @define-color color11 #${colors.color11};
      #       @define-color color12 #${colors.color12};
      #       @define-color color13 #${colors.color13};
      #       @define-color color14 #${colors.color14};
      #       @define-color color15 #${colors.color15};

      #       @define-color red #${colors.red};
      #       @define-color green #${colors.green};
      #       @define-color yellow #${colors.yellow};
      #       @define-color blue #${colors.blue};
      #       @define-color magenta #${colors.magenta};
      #       @define-color cyan #${colors.cyan};
      #     '';
      # };
      "gammastep" = {
        source = ../../../dotfiles/gammastep;
        recursive = true;
      };
    };
  };
}
