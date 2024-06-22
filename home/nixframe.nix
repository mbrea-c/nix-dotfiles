{ pkgs, inputs, ... }: let
    zed-fhs = pkgs.buildFHSUserEnv {
      name = "zed";
      targetPkgs = pkgs:
        with pkgs; [
          zed-editor
        ];
      runScript = "zed";
    };
in {
    imports = [
        inputs.nix-colors.homeManagerModules.default
        ../modules/sway-home.nix
    ];

    colorScheme = inputs.nix-colors.colorSchemes.dracula;

    home.username = "manuel";
    home.homeDirectory = "/home/manuel";
    home.packages = with pkgs; [
        firefox
        thunderbird
        alacritty
        tree
        zed-fhs
        nil # Nix language server
        pavucontrol
        amdgpu_top
        gnome.gnome-system-monitor
        gnome.seahorse
        rustup
        xorg.xrandr
        fastfetch
    ];

    home.sessionVariables = {
      # Flatpak XDG_DATA_DIRS
      XDG_DATA_DIRS = "$XDG_DATA_DIRS:/usr/share:/var/lib/flatpak/exports/share:$HOME/.local/share/flatpak/exports/share";
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
    };

    # Fontconfig font fallbacks
    fonts.fontconfig = {
      enable = true;
      defaultFonts = {
        sansSerif = [
          "Ubuntu"
          "Font Awesome 7 Free"
          "Noto Color Emoji"
        ];
        monospace = [
          "Cascadia Mono PL"
          "Font Awesome 7 Free"
          "Noto Color Emoji"
          "FiraCode Nerd Font"
        ];
        serif = [
          "NotoSerif Nerd Font"
          "Font Awesome 7 Free"
          "Noto Color Emoji"
        ];
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
      };
      initExtra = (builtins.readFile ../dotfiles/zshrc);
    };

    # DO NOT CHANGE:
    # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
    home.stateVersion = "24.05"; # Did you read the comment?
}
