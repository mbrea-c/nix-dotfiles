{ config, lib, pkgs, inputs, ... }:
{
    imports = [
        inputs.nixos-cosmic.nixosModules.default
    ];
    # security.pam.services.cosmic-greeter.enableGnomeKeyring = true;
    # security.pam.services.greetd.enableGnomeKeyring = true;
    # services.gnome.gnome-keyring.enable = true;
}
