# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{
  pkgs,
  lib,
  config,
  ...
}:
{
  imports = [
    # Include the results of the hardware scan.
    # inputs.disko.nixosModules.disko
    # ./disko.nix
    ../shared/qemu-guest.nix
    ./forgejo.nix
  ];

  options = {
    gitslayer = {
      staticIpv4 = lib.mkOption {
        type = lib.types.str;
        default = "192.168.1.42";
      };
      gatewayIpv4 = lib.mkOption {
        type = lib.types.str;
        default = "192.168.1.254";
      };
    };
  };

  config =
    let
      interfaceName = "vmnetwork";
    in
    {
      networking.hostName = lib.mkDefault "gitslayer"; # Define your hostname.
      environment.sessionVariables = {
        NIXOS_CONFIG_NAME = config.networking.hostName;
      };

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

      # Define a user account. Don't forget to set a password with ‘passwd’.
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

      networking.useNetworkd = true;
      networking.firewall = {
        enable = false;
      };
      systemd.network = {
        enable = true;
        networks."${interfaceName}" = {
          enable = true;
          matchConfig = {
            Type = "ether";
            Driver = "virtio_net";
          };
          networkConfig = {
            Address = "${config.gitslayer.staticIpv4}/24";
            Gateway = config.gitslayer.gatewayIpv4;
          };
          linkConfig = {
            RequiredForOnline = "routable";
          };
        };
      };

      fileSystems."/" = {
        device = "/dev/disk/by-label/nixos";
        autoResize = true;
        fsType = "ext4";
      };

      system.stateVersion = "24.05"; # Did you read the comment?
    };
}
