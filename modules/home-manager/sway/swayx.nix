{ lib, config, pkgs, inputs, colorscheme, ... }:
let
  cfg = config.swayx;
  outputMaker = import ../../../utils/swayoutputmaker.nix;
in {

  options = with lib; {
    swayx = {
      enable = lib.mkEnableOption "Enable Module";
      settings = mkOption {
        type = attrsOf anything;
        description =
          "Configuration that will be used to generate the sway config file";
        default = {
          inherit (outputMaker {
            primary = "eDP-2";
            secondary = "Dell Inc. DELL S2721DGF GV1KT83";
            primaryScale = "1.5";
            secondaryScale = "1.0";
          })
            outputs workspaces;
          dwt = true;
        };
      };
    };
  };

  config = lib.mkIf cfg.enable {
    systemd.user.targets.sway-session = {
      Unit = { Description = "Indicating that sway is running"; };
    };
    systemd.user.services = let
      make-srv = desc: exec: {
        Unit = {
          Description = desc;
          Requisite = [ "sway-session.target" ];
        };
        Install = { WantedBy = [ "sway-session.target" ]; };
        Service = {
          Type = "simple";
          ExecStart = exec;
        };
      };
    in {
      mako-srv = make-srv "Notification daemon" "${pkgs.mako}/bin/mako";
      gammastep-srv = make-srv "Night light for wayland sessions"
        "${pkgs.gammastep}/bin/gammastep";
      nmapplet-srv = make-srv "Network manager applet service"
        "${pkgs.networkmanagerapplet}/bin/nm-applet";
      blueman-srv = make-srv "Blueman bluetooth manager service"
        "${pkgs.blueman}/bin/blueman-applet";
    };

    xdg.configFile = {
      "sway/config" = {
        text = (import ../utils/swayconfig.nix) cfg.settings;
        recursive = true;
      };
      "waybar" = {
        source = ../dotfiles/waybar;
        recursive = true;
      };
      "waybar/colors.css" = {
        text = let
          u = inputs.nix-color-utils.lib;
          colors = u.fromBase16 colorscheme;
          # css
        in ''
          @define-color foreground #${colors.foreground};
          @define-color background #${colors.background};

          @define-color color0  #${colors.color0};
          @define-color color1  #${colors.color1};
          @define-color color2  #${colors.color2};
          @define-color color3  #${colors.color3};
          @define-color color4  #${colors.color4};
          @define-color color5  #${colors.color5};
          @define-color color6  #${colors.color6};
          @define-color color7  #${colors.color7};
          @define-color color8  #${colors.color8};
          @define-color color9  #${colors.color9};
          @define-color color10 #${colors.color10};
          @define-color color11 #${colors.color11};
          @define-color color12 #${colors.color12};
          @define-color color13 #${colors.color13};
          @define-color color14 #${colors.color14};
          @define-color color15 #${colors.color15};

          @define-color red #${colors.red};
          @define-color green #${colors.green};
          @define-color yellow #${colors.yellow};
          @define-color blue #${colors.blue};
          @define-color magenta #${colors.magenta};
          @define-color cyan #${colors.cyan};
        '';
      };
      "gammastep" = {
        source = ../dotfiles/gammastep;
        recursive = true;
      };
    };
  };
}
