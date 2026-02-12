{ pkgs, ... }:
{
  gtk = {
    enable = true;
    theme = {
      name = "Catppuccin-Macchiato-Standard-Blue-Dark";
      package = pkgs.catppuccin-gtk.override {
        accents = [ "blue" ];
        size = "standard";
        variant = "macchiato";
      };
    };
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.catppuccin-papirus-folders.override {
        flavor = "macchiato";
        accent = "blue";
      };
    };
    cursorTheme = {
      name = "Catppuccin-Macchiato-Dark-Cursors";
      package = pkgs.catppuccin-cursors.macchiatoDark;
    };
    gtk3 = {
      extraConfig.gtk-application-prefer-dark-theme = true;
    };
    home.pointerCursor = {
      gtk.enable = true;
      name = "Catppuccin-Macchiato-Dark-Cursors";
      package = pkgs.catppuccin-cursors.macchiatoDark;
      size = 16;
    };
  };

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      gtk-theme = "Catppuccin-Macchiato-Standard-Blue-Dark";
      color-scheme = "prefer-dark";
    };

    # For Gnome shell
    "org/gnome/shell/extensions/user-theme" = {
      name = "Catppuccin-Macchiato-Standard-Blue-Dark";
    };
  };
}
