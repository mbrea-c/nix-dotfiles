{ self, pkgs, inputs, colorscheme, lib, ... }:
let
  zed-fhs = pkgs.buildFHSUserEnv {
    name = "zed";
    targetPkgs = pkgs: with pkgs; [ zed-editor ];
    runScript = "zed";
  };
  scripts = (import ./scripts.nix) { inherit pkgs; };
  inherit (inputs.nix-colors.lib-contrib { inherit pkgs; }) gtkThemeFromScheme;

  pkgs-art = with pkgs; [ blender gimp libresprite krita ];
in {
  imports = [
    inputs.nix-colors.homeManagerModules.default
    ../modules/home-manager/sway/swayx.nix
    self.outputs.homeManagerModules.zsh
    self.outputs.homeManagerModules.fonts
  ];

  colorScheme = inputs.nix-colors.colorSchemes.dracula;

  home.username = "manuel";
  home.homeDirectory = "/home/manuel";
  home.packages = lib.lists.unique ((with pkgs; [
    firefox
    thunderbird
    alacritty
    mpv
    obs-studio
    tree
    zed-editor
    # zed-fhs
    nil # Nix language server
    pavucontrol
    amdgpu_top
    mission-center
    gnome-system-monitor
    seahorse
    gcc
    rustup
    xorg.xrandr
    python3
    fastfetch
    lf
    trash-cli
    helix # For trying it out!
    vulkan-tools
    sshfs # For backing up framevoid to nixframe
    brightnessctl
    ripgrep
    zathura
    graphviz
    libheif
    imv # image viewer
    typst
    d-spy
    zotero
    (lutris.override {
      extraLibraries = pkgs: [ ];
      extraPkgs = pkgs: [ ];
    })
  ]) ++ scripts ++ pkgs-art);

  home.sessionVariables = {
    # Flatpak XDG_DATA_DIRS
    XDG_DATA_DIRS =
      "$XDG_DATA_DIRS:/usr/share:/var/lib/flatpak/exports/share:$HOME/.local/share/flatpak/exports/share";
    NIX_CONFIG_PATH = "$HOME/src/nix-dotfiles";
    NIXOS_OZONE_WL = "1";
  };

  home.sessionPath = [ "$HOME/.cargo/bin" "$HOME/scripts" ];

  swayx = { enable = true; };

  xdg = {
    enable = true;
    userDirs = {
      createDirectories = true;
      desktop = "/home/manuel/Desktop";
      documents = "/home/manuel/Documents";
      download = "/home/manuel/Downloads";
      music = "/home/manuel/Music";
      pictures = "/home/manuel/Pictures";
      videos = "/home/manuel/Videos";
    };
    mimeApps = {
      enable = true;
      defaultApplications = {
        # Check mime-types using `xdg-mime query filetype filename.extension`
        "image/png" = "imv.desktop";
        "text/html" = "firefox.desktop";
        "application/pdf" = "org.pwmt.zathura.desktop";
      };
    };
    desktopEntries = {
      imv = {
        name = "imv";
        exec = "${pkgs.imv}/bin/imv";
      };
      discord = {
        name = "Discord";
        type = "Application";
        terminal = false;
        exec = ''${pkgs.chromium}/bin/chromium --app="https://discord.com"'';
      };
    };
  };

  gtk = {
    enable = true;
    # theme = {
    #   name = "Materia-dark";
    #   package = pkgs.materia-theme;
    # };
    theme = {
      name = "${colorscheme.slug}";
      package = gtkThemeFromScheme { scheme = colorscheme; };
    };
  };

  programs.alacritty = {
    enable = true;
    settings = {
      colors = let col = inputs.nix-color-utils.lib.fromBase16 colorscheme;
      in {
        primary = {
          foreground = "#${col.foreground}";
          background = "#${col.background}";
        };
        cursor = {
          text = "#${col.background}";
          background = "#${col.foreground}";
        };
        normal = {
          black = "#${col.black}";
          red = "#${col.red}";
          green = "#${col.green}";
          yellow = "#${col.yellow}";
          blue = "#${col.blue}";
          magenta = "#${col.magenta}";
          cyan = "#${col.cyan}";
          white = "#${col.white}";
        };
        bright = {
          black = "#${col.color8}";
          red = "#${col.color9}";
          green = "#${col.color10}";
          yellow = "#${col.color11}";
          blue = "#${col.color12}";
          magenta = "#${col.color13}";
          cyan = "#${col.color14}";
          white = "#${col.color15}";
        };
      };
    };
  };

  programs.git = {
    enable = true;
    userName = "Manuel Brea Carreras";
    userEmail = "m.brea.carreras@gmail.com";
    extraConfig = { pull = { rebase = true; }; };
  };

  # DO NOT CHANGE:
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  home.stateVersion = "24.05"; # Did you read the comment?
}
