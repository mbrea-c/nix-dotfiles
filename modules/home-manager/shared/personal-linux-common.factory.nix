# This is a module factory
params@{
  blender-autorender,
  nix-colors,
  nix-color-utils,
  ...
}:
{
  pkgs,
  lib,
  config,
  ...
}:
let
  flakeRoot = ../../../.;
  scripts = (import ../../../scripts/scripts.nix) { inherit pkgs; };
  pkgs-art =
    (with pkgs; [
      blender
      gimp
      libresprite
      krita
      inkscape
    ])
    ++ [
      blender-autorender.packages."${pkgs.stdenv.hostPlatform.system}".default
    ];
in
{
  imports = [
    nix-colors.homeManagerModules.default
    ./sway/swayx.nix
    ./sway/sway-home-deps.nix
    ./virtual-machines.nix
    ./my-firefox.nix
    (import ./ghostty.factory.nix params)
    (import ./kitty.factory.nix params)
    ./qt.nix
    ./zsh.nix
    ./fonts.nix
    (import (flakeRoot + /modules/shared/dotcolors.factory.nix) params)
  ];

  home.username = "manuel";
  home.homeDirectory = "/home/manuel";

  home.packages = lib.lists.unique (
    (with pkgs; [
      strawberry
      chromium
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
      yazi
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
      neovide
      teamtype
      transmission_4-gtk

      # xfce.thunar
      # xfce.thunar-archive-plugin
      nemo
      file-roller
      zip
      unzip

      bottom
      # grayjay
      shotman
      (pkgs.callPackage ../../../pkgs/tracy { })
    ])
    ++ scripts
    ++ pkgs-art
  );

  home.sessionVariables = {
    # Flatpak XDG_DATA_DIRS
    XDG_DATA_DIRS = "$XDG_DATA_DIRS:/usr/share:/var/lib/flatpak/exports/share:$HOME/.local/share/flatpak/exports/share";
    NIX_CONFIG_PATH = "$HOME/src/nix-dotfiles";
    NIXOS_OZONE_WL = "1";
  };

  home.sessionPath = [
    "$HOME/.cargo/bin"
    "$HOME/scripts"
  ];

  swayx = {
    enable = true;
  };

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
        "image/jpeg" = "imv.desktop";
        "text/html" = "firefox-beta.desktop";
        "application/pdf" = "org.pwmt.zathura.desktop";
        "x-scheme-handler/http" = "firefox-beta.desktop";
        "x-scheme-handler/https" = "firefox-beta.desktop";
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
    configFile = {
      "neovide/config.toml" = {
        text = builtins.readFile ../../../dotfiles/neovide/config.toml;
      };
    };
  };

  gtk = {
    enable = true;
    theme = {
      name = "Tokyonight-Dark";
      package = pkgs.tokyonight-gtk-theme;
    };
    # theme = {
    #   name = "${colorscheme.slug}";
    #   package = gtkThemeFromScheme { scheme = colorscheme; };
    # };
  };

  programs.alacritty = {
    enable = true;
    settings = {
      font = {
        size = 11;
        bold.style = "Extrabold";
        bold_italic.style = "Extrabold Italic";
        italic.style = "Italic";
      };
      colors =
        let
          col = nix-color-utils.lib.fromBase16 config.dotcolors.colorscheme;
        in
        {
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
    settings = {
      user = {
        name = "Manuel Brea Carreras";
        email = "m.brea.carreras@gmail.com";
      };
      pull = {
        rebase = true;
      };
    };
    lfs.enable = true;
  };

  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
    nix-direnv.enable = true;
  };

  # DO NOT CHANGE:
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  home.stateVersion = "24.05"; # Did you read the comment?
}
