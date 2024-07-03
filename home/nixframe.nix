{ pkgs, inputs, colorscheme, lib, ... }:
let
  zed-fhs = pkgs.buildFHSUserEnv {
    name = "zed";
    targetPkgs = pkgs: with pkgs; [ zed-editor ];
    runScript = "zed";
  };
  scripts = (import ./scripts.nix) { inherit pkgs; };
  inherit (inputs.nix-colors.lib-contrib { inherit pkgs; }) gtkThemeFromScheme;
  bevy_deps = with pkgs; [
    pkg-config
    udev.dev
    alsa-lib.dev
    vulkan-loader.dev
    xorg.libX11
    xorg.libXrandr
    xorg.libXcursor
    xorg.libXi
    xorg.libXtst
    libxkbcommon.dev
    wayland.dev
    openssl.dev
  ];

in {
  imports =
    [ inputs.nix-colors.homeManagerModules.default ../modules/sway-home.nix ];

  colorScheme = inputs.nix-colors.colorSchemes.dracula;

  home.username = "manuel";
  home.homeDirectory = "/home/manuel";
  home.packages = lib.lists.unique ((with pkgs; [
    firefox
    thunderbird
    alacritty
    tree
    zed-editor
    # zed-fhs
    nil # Nix language server
    pavucontrol
    amdgpu_top
    gnome.gnome-system-monitor
    gnome.seahorse
    gcc
    rustup
    xorg.xrandr
    fastfetch
    lf
    trash-cli
    helix # For trying it out!
  ]) ++ scripts ++ bevy_deps);

  home.sessionVariables = {
    # Flatpak XDG_DATA_DIRS
    XDG_DATA_DIRS =
      "$XDG_DATA_DIRS:/usr/share:/var/lib/flatpak/exports/share:$HOME/.local/share/flatpak/exports/share";
    NIX_CONFIG_PATH = "$HOME/src/nix-dotfiles";
  };

  home.sessionPath = [ "$HOME/.cargo/bin" "$HOME/scripts" ];

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
  };

  # Fontconfig font fallbacks
  fonts.fontconfig = {
    enable = true;
    defaultFonts = {
      sansSerif = [ "Ubuntu" "Font Awesome 7 Free" "Noto Color Emoji" ];
      monospace = [
        "Cascadia Mono PL"
        "Font Awesome 7 Free"
        "Noto Color Emoji"
        "FiraCode Nerd Font"
      ];
      serif =
        [ "NotoSerif Nerd Font" "Font Awesome 7 Free" "Noto Color Emoji" ];
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

  programs.zsh = {
    enable = true;
    dotDir = ".config/zsh";
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    shellAliases = {
      ls = "ls --group-directories-first --color=auto";
      ll = "ls -l";
      la = "ls -a";
      lla = "ls -la";
      gst = "git status";
      vim = "nvim";
    };
    initExtra = (builtins.readFile ../dotfiles/zshrc);
  };

  # DO NOT CHANGE:
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  home.stateVersion = "24.05"; # Did you read the comment?
}
