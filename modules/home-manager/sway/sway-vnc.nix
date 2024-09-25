{ lib, config, pkgs, inputs, colorscheme, ... }:
let
  cfg = config.sway-vnc;
  configurator = import ./swayconfig.nix;
  primary = "HDMI-A-1";
  scale = "1.0";
  outputs = [{
    name = primary;
    scale = scale;
  }];
  workspaces = [
    {
      name = "1";
      outputList = [ primary ];
    }
    {
      name = "2";
      outputList = [ primary ];
    }
    {
      name = "3";
      outputList = [ primary ];
    }
    {
      name = "4";
      outputList = [ primary ];
    }
    {
      name = "5";
      outputList = [ primary ];
    }
    {
      name = "6";
      outputList = [ primary ];
    }
    {
      name = "7";
      outputList = [ primary ];
    }
    {
      name = "8";
      outputList = [ primary ];
    }
    {
      name = "9";
      outputList = [ primary ];
    }
    {
      name = "10";
      outputList = [ primary ];
    }
  ];
in {

  options = { sway-vnc = { enable = lib.mkEnableOption "Enable Module"; }; };

  config = lib.mkIf cfg.enable {
    home.packages = [
      (pkgs.writeShellScriptBin "sway-vnc" ''
        export WLR_BACKENDS=headless
        export WLR_LIBINPUT_NO_DEVICES=1
        exec ${pkgs.sway}/bin/sway -c $HOME/.config/sway/config-vnc
      '')
    ];
    xdg.configFile = {
      "sway/config-vnc" = {
        text = configurator {
          outputs = outputs;
          workspaces = workspaces;
          dwt = true;
          exec =
            [ "${pkgs.mako}/bin/mako" "sleep 5 && ${pkgs.wayvnc}/bin/wayvnc" ];
          swaybarCommand = "${pkgs.waybar}/bin/waybar";
        };
      };
      "waybar" = {
        source = ../../../dotfiles/waybar;
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
    };
  };
}
