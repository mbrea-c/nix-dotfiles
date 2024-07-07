{ pkgs, inputs, ... }: {
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
    "sway" = {
      source = ../dotfiles/sway;
      recursive = true;
    };
    "waybar" = {
      source = ../dotfiles/waybar;
      recursive = true;
    };
    "gammastep" = {
      source = ../dotfiles/gammastep;
      recursive = true;
    };
  };
}
