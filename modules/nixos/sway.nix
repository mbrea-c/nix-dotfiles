{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    wl-clipboard
    mako
    wofi
    wdisplays
    rofi
    swaybg
    waybar
    gammastep
    geoclue2
    networkmanagerapplet
    blueman
  ];

  programs.sway = {
    enable = true;
    wrapperFeatures = {
      base = true;
      gtk = true;
    };
  };
}
