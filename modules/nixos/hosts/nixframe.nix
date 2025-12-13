# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ pkgs, ... }:
{
  imports = [
    # Include the results of the hardware scan.
    ../hardware/nixframe.nix
    ./personal-linux-common.nix
  ];

  networking.hostName = "nixframe"; # Define your hostname.
  environment.sessionVariables = {
    NIXOS_CONFIG_NAME = "nixframe";
  };

  services.ollama = {
    package = pkgs.ollama-rocm;
    environmentVariables = {
      HCC_AMDGPU_TARGET = "gfx1102";
    };
    rocmOverrideGfx = "11.0.2";
  };
  # services.openssh = {
  #   enable = true;
  #   ports = [ 22 ];
  #   settings = {
  #     PasswordAuthentication = true;
  #     AllowUsers =
  #       null; # Allows all users by default. Can be [ "user1" "user2" ]
  #     UseDns = true;
  #     X11Forwarding = false;
  #     PermitRootLogin =
  #       "prohibit-password"; # "yes", "without-password", "prohibit-password", "forced-commands-only", "no"
  #   };
  # };

  # DO NOT CHANGE:
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "24.05"; # Did you read the comment?
}
