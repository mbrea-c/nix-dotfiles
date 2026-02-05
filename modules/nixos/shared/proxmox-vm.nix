# Common configuration for standard proxmox VM hosts in our cluster

{ pkgs, lib, ... }:
{
  imports = [ ./qemu-guest.nix ];

  boot = {
    loader.grub.enable = true; # Use the boot drive for GRUB
    loader.grub.devices = [ "nodev" ];
    growPartition = true;
    kernelPackages = pkgs.linuxPackages_latest;
  };

  nix = {
    settings.experimental-features = [
      "nix-command"
      "flakes"
      "pipe-operators"
    ];
    # Allow remote updates
    settings.trusted-users = [
      "root"
      "@wheel"
    ];
  };

  # Set your time zone.
  time.timeZone = "Europe/London";

  security.sudo.wheelNeedsPassword = false;

  services = {
    qemuGuest.enable = lib.mkDefault true;

    # locate command
    locate = {
      enable = true;
      package = pkgs.plocate;
      # To disable auto updating of db, set to "never"
      interval = "02:15";
    };

    openssh = {
      enable = true;
      settings = {
        PasswordAuthentication = false;
        KbdInteractiveAuthentication = false;
      };
    };
  };

  programs = {
    ssh.startAgent = true;
    zsh.enable = true;
  };

  # Define a user account
  users.users.manuel = {
    initialPassword = "guest";
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

    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIL1KzvxpqpGDRfkdPAqkdAkkGjKK5sNE7IF0Okm9qO91 m.brea.carreras@gmail.com"
    ];
  };

  environment.systemPackages = with pkgs; [
    neovim
    wget
    git
    nix-index
    man-pages
    man-pages-posix
    man-db
  ];

  environment.sessionVariables = {
    EDITOR = "nvim";
  };

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

  fileSystems."/" = {
    device = "/dev/disk/by-label/nixos";
    autoResize = true;
    fsType = "ext4";
  };
}
