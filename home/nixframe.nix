{ pkgs, inputs, colorscheme, ... }:
let
  zed-fhs = pkgs.buildFHSUserEnv {
    name = "zed";
    targetPkgs = pkgs: with pkgs; [ zed-editor ];
    runScript = "zed";
  };
  zeddit =
    pkgs.writeShellScriptBin "zeddit" (builtins.readFile ../scripts/zeddit);
  inherit (inputs.nix-colors.lib-contrib { inherit pkgs; }) gtkThemeFromScheme;
in {
  imports =
    [ inputs.nix-colors.homeManagerModules.default ../modules/sway-home.nix ];

  colorScheme = inputs.nix-colors.colorSchemes.dracula;

  home.username = "manuel";
  home.homeDirectory = "/home/manuel";
  home.packages = with pkgs; [
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
    alsa-lib # build dependency for my rust stuff
    pkg-config
    gcc
    rustup
    xorg.xrandr
    fastfetch
    zeddit
  ];

  home.sessionVariables = {
    # Flatpak XDG_DATA_DIRS
    XDG_DATA_DIRS =
      "$XDG_DATA_DIRS:/usr/share:/var/lib/flatpak/exports/share:$HOME/.local/share/flatpak/exports/share";
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
