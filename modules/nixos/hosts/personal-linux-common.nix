{ pkgs, self, ... }:
let
  nixvim = self.packages."${pkgs.system}".manuvim;
in
{
  imports = [
    # Include the results of the hardware scan.
    ../sway.nix
    ../gaming.nix
    ../virtual-machines.nix
    # ../modules/cosmic.nix
  ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Issues with dynamically linked libraries
  programs.nix-ld.enable = true;
  # programs.nix-ld.libraries = with pkgs; [
  #   xorg.libX11
  #   xorg.libXcursor
  #   xorg.libxcb
  #   xorg.libXi
  #   libxkbcommon
  # ];

  # Flakes and nix-command
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  # Kernel package version
  boot.kernelPackages = pkgs.linuxPackages_latest;

  networking.networkmanager = {
    enable = true;
    plugins = with pkgs; [ networkmanager-openvpn ];
  };

  # Set your time zone.
  time.timeZone = "Europe/London";

  # Select internationalisation properties.
  # i18n.defaultLocale = "en_US.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  #   useXkbConfig = true; # use xkb.options in tty.
  # };

  hardware = {
    bluetooth = {
      enable = true;
      powerOnBoot = true;
    };
  };

  services = {
    # locate command
    locate = {
      enable = true;
      package = pkgs.plocate;
      # To disable auto updating of db, set to "never"
      interval = "02:15";
    };

    displayManager.gdm.enable = true;

    # TODO: Do we still need this?
    xserver.enable = true;

    gvfs = {
      # Mount, trash, and other functionality for file managers
      enable = true;
    };

    # Cosmic greeter and DE
    # desktopManager.cosmic.enable = true;
    # displayManager.cosmic-greeter.enable = true;

    # Enable sound.
    pipewire = {
      enable = true;
      pulse.enable = true;
    };

    ollama = {
      enable = false;
    };
    flatpak.enable = true;
    fwupd.enable = true;
    power-profiles-daemon.enable = true;
    upower = {
      enable = true;
      percentageLow = 15;
      percentageCritical = 5;
      percentageAction = 3;
      criticalPowerAction = "HybridSleep";
    };

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
    nixvim
    wget
    git
    nix-index
    man-pages
    man-pages-posix
    man-db
  ];

  environment.sessionVariables = {
    EDITOR = "${nixvim}/bin/nvim";
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

  # environment.variables = {
  #   XDG_RUNTIME_DIR = "/run/user/$UID";
  # };

  programs.ssh.startAgent = true;
  programs.zsh.enable = true;
  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  networking.firewall = {
    enable = false;
    allowedTCPPorts = [ 7943 ];
    allowedUDPPorts = [
      1337
      34197
    ];
  };

  programs.dconf.enable = true;
}
