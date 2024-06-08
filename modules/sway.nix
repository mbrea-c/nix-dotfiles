{ config, lib, pkgs, ... }:
{
    environment.systemPackages = with pkgs; [
        wl-clipboard
        mako
        alacritty
        wofi
        wdisplays
        rofi-wayland
    ];

    programs.sway = {
        enable = true;
        wrapperFeatures = {
            base = true;
            gtk = true;
        };
    };
}
