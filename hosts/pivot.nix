# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ pkgs, inputs, ... }: {
  imports = [ # Include the results of the hardware scan.
    inputs.disko.nixosModules.disko
    ../disko/pivot.nix
    # ../hardware/nixframe.nix
    # ./personal-linux-common.nix
  ];

  networking.hostName = "pivot"; # Define your hostname.
  environment.sessionVariables = { NIXOS_CONFIG_NAME = "pivot"; };

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Flakes and nix-command
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Kernel package version
  boot.kernelPackages = pkgs.linuxPackages_latest;

  networking.networkmanager.enable =
    true; # Easiest to use and most distros use this by default.

  # Set your time zone.
  time.timeZone = "Europe/London";

  services = {
    # locate command
    locate = {
      enable = true;
      package = pkgs.plocate;
      # To disable auto updating of db, set to "never"
      interval = "02:15";
    };

    xserver = {
      enable = true;
      displayManager.gdm.enable = true;
    };

    # Cosmic greeter and DE
    # desktopManager.cosmic.enable = true;
    # displayManager.cosmic-greeter.enable = true;

    # Enable sound.
    pipewire = {
      enable = true;
      pulse.enable = true;
    };

    flatpak.enable = true;
    fwupd.enable = true;
    power-profiles-daemon.enable = true;

    # Enable touchpad support (enabled default in most desktopManager).
    # libinput.enable = true;

    # Enable CUPS to print documents.
    # printing.enable = true;
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.manuel = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "networkmanager"
      "video"
      "input"
      "audio"
      "libirtd"
    ]; # Enable ‘sudo’ for the user.
    shell = pkgs.zsh;
    packages = [ ];
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    neovim
    wget
    git
    nix-index
    man-pages
    man-pages-posix
    man-db
  ];

  environment.sessionVariables = { EDITOR = "nvim"; };

  documentation = {
    enable = true;
    dev.enable = true;
    man = {
      enable = true;
      mandoc.enable = false;
      man-db.enable = true;
      generateCaches = true;
    };
    info.enable = true;
    doc.enable = true;
    nixos.enable = true;
  };

  programs.ssh.startAgent = true;
  programs.zsh.enable = true;
}
