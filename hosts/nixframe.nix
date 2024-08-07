# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ ... }: {
  imports = [ # Include the results of the hardware scan.
    ../hardware/nixframe.nix
    ./personal-linux-common.nix
  ];

  networking.hostName = "nixframe"; # Define your hostname.
  environment.sessionVariables = { NIXOS_CONFIG_NAME = "nixframe"; };

  # DO NOT CHANGE:
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "24.05"; # Did you read the comment?
}
