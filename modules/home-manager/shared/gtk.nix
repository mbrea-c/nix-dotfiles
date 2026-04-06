{ pkgs, ... }:
let
  catpuccin-gtk-theme = {
    name = "catppuccin-macchiato-blue-standard";
    package = pkgs.catppuccin-gtk.override {
      accents = [ "blue" ];
      size = "standard";
      variant = "macchiato";
    };
  };
in
{
  gtk = {
    enable = true;

    gtk2.theme = catpuccin-gtk-theme;
    gtk3.theme = catpuccin-gtk-theme;
    gtk4.theme = catpuccin-gtk-theme;

    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.catppuccin-papirus-folders.override {
        flavor = "macchiato";
        accent = "blue";
      };
    };
    cursorTheme = {
      name = "Catppuccin Macchiato Dark";
      package = pkgs.catppuccin-cursors.macchiatoDark;
    };
    gtk3 = {
      extraConfig.gtk-application-prefer-dark-theme = true;
    };
  };

  home.pointerCursor = {
    gtk.enable = true;
    name = "Catppuccin Macchiato Dark";
    package = pkgs.catppuccin-cursors.macchiatoDark;
    size = 16;
  };

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      gtk-theme = "catppuccin-macchiato-blue-standard";
      color-scheme = "prefer-dark";
    };

    # For Gnome shell
    "org/gnome/shell/extensions/user-theme" = {
      name = "catppuccin-macchiato-blue-standard";
    };
  };
}
