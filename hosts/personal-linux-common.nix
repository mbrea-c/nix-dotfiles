{ config, lib, pkgs, inputs, colorscheme, self, ... }:
let nixvim = self.packages."${pkgs.system}".manuvim;
in {
  imports = [ # Include the results of the hardware scan.
    ../modules/sway-host.nix
    ../modules/cosmic.nix
  ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Issues with dynamically linked libraries
  programs.nix-ld.enable = true;

  # Flakes and nix-command
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  services.flatpak.enable = true;
  services.fwupd.enable = true;
  services.power-profiles-daemon.enable = true;

  # Kernel package version
  boot.kernelPackages = pkgs.linuxPackages_latest;

  networking.hostName = "nixframe"; # Define your hostname.
  networking.networkmanager.enable =
    true; # Easiest to use and most distros use this by default.

  # Set your time zone.
  time.timeZone = "Europe/London";

  # Select internationalisation properties.
  # i18n.defaultLocale = "en_US.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  #   useXkbConfig = true; # use xkb.options in tty.
  # };

  # Cosmic greeter and DE
  services.desktopManager.cosmic.enable = true;
  services.displayManager.cosmic-greeter.enable = true;

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.manuel = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "networkmanager"
      "video"
      "input"
      "audio"
    ]; # Enable ‘sudo’ for the user.
    shell = pkgs.zsh;
    packages = [ ];
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [ nixvim wget git nix-index ];

  environment.sessionVariables = { EDITOR = "${nixvim}/bin/nvim"; };

  # environment.variables = {
  #   XDG_RUNTIME_DIR = "/run/user/$UID";
  # };

  programs.zsh.enable = true;
  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };
  fonts.packages = with pkgs; [
    font-awesome
    ubuntu_font_family
    cascadia-code
    nerdfonts
  ];

  networking.firewall = {
    enable = true;
    allowedTCPPorts = [ 7943 ];
    allowedUDPPorts = [ 1337 ];
  };
}
