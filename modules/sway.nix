{ config, lib, pkgs, ... }:
{
    environment.systemPackages = with pkgs; [
        wl-clipboard
        mako
        wofi
        wdisplays
        rofi-wayland
        swaybg
    ];

    programs.sway = {
        enable = true;
        wrapperFeatures = {
            base = true;
            gtk = true;
        };
    };

    programs.waybar.enable = true;
}
