{ pkgs, ... }:
{
    home.username = "manuel";
    home.homeDirectory = "/home/manuel";
    home.packages = with pkgs; [
        firefox
        thunderbird
        tree
        zed-editor
        nil # Nix language server
        pavucontrol
        amdgpu_top
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

      configFile = {
        "sway" = {
            source = ../dotfiles/sway;
            recursive = true;
        };
      };
    };

    fonts.fontconfig = {
      enable = true;
      defaultFonts = {
        sansSerif = [
          "Ubuntu"
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
