{ config, lib, pkgs, ... }:
{
    environment.systemPackages = with pkgs; [
        wl-clipboard
        mako
        alacritty
        wofi
    ];

    programs.sway = {
        enable = true;
        wrapperFeatures = {
            base = true;
            gtk = true;
        };
    };
}
